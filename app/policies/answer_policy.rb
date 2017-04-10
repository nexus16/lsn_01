class AnswerPolicy < ApplicationPolicy
  attr_reader :user, :answer

  def initialize user, answer
    @user = user
    @answer = answer
  end

  def update?
    @answer.user == @user
  end

  def destroy?
    @answer.user == @user
  end
end
