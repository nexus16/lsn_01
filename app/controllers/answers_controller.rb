class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: :create

  def new
  end

  def create
    if params[:answer][:parent_id]
      parent = @question.answers.find_by id: params[:answer][:parent_id]
      if parent
        @answer = parent.children.new answer_params
        @answer.question = @question
      else
        flash[:danger] = t "answer_not_found"
        respond_to root_path
      end
    else
      @answer = @question.answers.new answer_params
    end
    respond_to do |format|
      if @answer.save
        format.js
      end
    end
  end

  private
  def answer_params
    params.require(:answer).permit :content, :user_id
  end

  def find_question
    @question = Question.find_by id: params[:question_id]
    unless @question
      flash[:danger] = t "question_not_found"
      respond_to root_path
    end
  end
end
