class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize user, question
    @user = user
    @question = question
  end

  def update?
    @question.user == @user
  end

  def destroy?
    @question.user == @user || @user.is_admin?
  end
end
