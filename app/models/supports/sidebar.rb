class Supports::Sidebar
  def initialize subjects = nil
    @subjects = subjects
  end

  def popular_tag
    ActsAsTaggableOn::Tag.most_used 10
  end

  def hot_user
    subjects_id = nil
    if @subjects
      subjects_id = @subjects.map{|subject| subject[:id]}
    end
    UserSortByTimeService.new("for-month", subjects_id).perform[0..4]
  end

  def hot_question
    questions = QuestionSortByTimeService.new("for-month").perform
    if @subjects
      subjects_id = @subjects.map{|subject| subject[:id]}
      questions = questions.select{|question|
        subjects_id.include?(question.category_id)}
    else
    end
    questions[0..4]
  end
end
