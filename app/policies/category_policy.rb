class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize user, category
    @user = user
    @category = category
  end

  def create?
    @user.is_admin?
  end

  def update
    @user.is_admin?
  end

  def destroy
    @user.is_admin?
  end
end
