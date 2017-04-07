class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create]

  def new
  end

  def create
    if params[:answer][:parent_id]
      parent = @question.answers.find_by id: params[:answer][:parent_id]
      if parent
        @answer = parent.children.build answer_params
        @answer.question_id = @question.id
      else
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

  def edit
  end

  def update
  end

  private
  def answer_params
    params.require(:answer).permit :content, :user_id
  end

  def find_question
    @question = Question.find_by id: params[:question_id]
    respond_to root_path unless @question
  end
end
