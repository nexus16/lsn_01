class Supports::Home
  def initialize current_user
    @current_user = current_user
  end

  def list_question
    Question.order_DESC
  end

  def hot_question
    QuestionSortByTimeService.new("for-month", 1).perform[0..4]
  end

  def list_class
    Category.roots
  end

  def list_object
    Category.leaves.map(&:name).uniq
  end

  def hot_user
    UserSortByTimeService.new("for-month", 1).perform[0..4]
  end

  def popular_tag
    ActsAsTaggableOn::Tag.most_used 10
  end

  def notifications
    @current_user.notifications.order_new_notifications
  end
end
