class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_question, except: [:new, :create]
  before_action :list_classes, only: [:new, :edit]
  before_action :authorize_question, only: [:update, :edit, :destroy]

  def show
    @supports_question = Supports::Question.new @question, user_signed_in?,
      current_user
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t "create_question_succes"
      redirect_to @question
    else
      flash[:error] = t "create_question_false"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "update_success"
      redirect_to @question
    else
      flash[:error] = t "update_false"
      redirect_to root_path
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "delete_success"
      redirect_to root_path
    else
      flash[:error] = t "delete_false"
      redirect_to @question
    end
  end

  private
  def question_params
    params.require(:question).permit :title, :content, :category_id
  end

  def find_question
    @question = Question.find_by id: params[:id]
    unless @question
      flash[:danger] = t "question_not_found"
      redirect_to root_path
    end
  end

  def list_classes
    @list_classes = Category.roots
  end

  def authorize_question
    authorize @question
  end
end
