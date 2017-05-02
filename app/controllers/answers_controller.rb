class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create, :destroy, :edit]
  before_action :find_answer, except: [:new, :create]
  before_action :authorize_answer, only: [:update, :edit, :destroy]

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
        @supports_question = Supports::Question.new @question, user_signed_in?,
          current_user
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.json{render json: @answer}
    end
  end

  def update
    if @answer.update_attributes answer_params
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = t "update_false"
      redirect_to root_path
    end
  end

  def destroy
    if @answer.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = t "delete_false"
      redirect_to @question
    end
  end

  private
  def answer_params
    params.require(:answer).permit :content, :user_id
  end

  def find_answer
    @answer = Answer.find_by id: params[:id]
    unless @answer
      flash[:danger] = t "answer_not_found"
      respond_to root_path
    end
  end

  def find_question
    @question = Question.find_by id: params[:question_id]
    unless @question
      flash[:danger] = t "question_not_found"
      respond_to root_path
    end
  end

  def authorize_answer
    authorize @answer
  end
end
