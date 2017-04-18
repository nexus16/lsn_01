class Admin::UsersController < Admin::AdminController
  def index
    @users = User.order_most_voted.paginate(page: params[:page],
      per_page: Settings.per_page)
    if params[:sort]
      service = SortByTimeService.new params[:sort], params[:page]
      @users = service.perform
      respond_to do |format|
        format.js
      end
    end
  end
end
