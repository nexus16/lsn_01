class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :load_sitebar

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def user_not_authorized
    flash[:error] = t "pundit.notifications"
    redirect_to request.referer || new_user_session_path
  end

  def load_sitebar
    @supports = Supports::Home.new current_user
  end
end
