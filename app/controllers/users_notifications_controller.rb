class UsersNotificationsController < ApplicationController
  def mark
    @users_notification = current_user.users_notifications.where(viewed: false).find(params[:id])
    @users_notification.update(viewed: true)

    render nothing: true, status: 200
  end
end
