class Admin::UsersController < Admin::AdminController
  require "will_paginate/array"

  def index
    @users = User.order_most_voted.paginate(page: params[:page],
      per_page: Settings.per_page)
    if params[:sort]
      service = UserSortByTimeService.new params[:sort]
      @users = service.perform
      @users = @users.paginate page: params[:page], per_page: Settings.per_page
      unless params[:page]
        respond_to do |format|
          format.js
        end
      end
    end
  end
end
