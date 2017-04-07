class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_question, except: :new
  before_action :list_class, only: [:new, :edit]
  before_action :check_current_user, only: [:edit, :delete]

  def show
    @supports = Supports::Home.new
    @answers = @question.list_answers
    @answer = Answer.new
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build question_params
    redirect_to @question if @question.save
  end

  def edit
  end

  def update
    @question.update_attributes question_params
    redirect_to @question
  end

  def delete
    @question.destroy
    redirect_to root_path
  end

  private
  def find_question
    @question = Question.find_by id: params[:id]
  end

  def question_params
    params.require(:question).permit :title, :content, :category_id
  end

  def list_class
    @list_class = Category.roots
  end

  def check_current_user
    redirect_to root_path unless @question.user == current_user
  end
end
