class Supports::Question
  def initialize question, user_signed_in, current_user
    @question = question
    @user_signed_in = user_signed_in
    @current_user = current_user
  end

  def report
    Report.new
  end

  def vote_question
    if @user_signed_in
      Vote.find_by(user_id: @current_user.id, votable_id: @question.id,
        votable_type: Question.name) || Vote.new
    else
      Vote.new
    end
  end

  def answers
    @question.answers
  end

  def new_answer
    Answer.new
  end
end
