class QuestionsController < ApplicationController
  def show
    @question = Question.find_by id: params[:id]
    if @question
      @supports = Supports::Question.new @question, user_signed_in?,
        current_user
    else
      flash[:danger] = t "question_not_found"
      redirect_to root_path
    end
  end
end
