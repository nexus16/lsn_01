class NotificationsController < ApplicationController
  def update
    noti = Notification.find_by id: params[:id]
    unless noti
      flash[:danger] = t "no_find_this_noti"
      redirect_to root_path
    end
    unless noti.update_attributes noti_params
      flash[:error] = t "update_false"
      redirect_to root_path
    end
  end

  private
  def noti_params
    params.require(:notification).permit :seen
  end
end
