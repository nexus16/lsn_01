class Admin::AdminController < ApplicationController
  layout "layouts/admin_layout"

  before_action :authenticate_user!
  before_action :is_admin?

  private
  def is_admin?
    redirect_to root_path unless current_user.is_admin?
  end
end
