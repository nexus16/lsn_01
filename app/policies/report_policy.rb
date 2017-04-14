class ReportPolicy < ApplicationPolicy
  def destroy?
    user.is_admin?
  end
end
