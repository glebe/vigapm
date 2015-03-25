class UsersNotificationsController < ApplicationController
  respond_to :json, only: :index
  respond_to :js, only: :mark

  def index
    @users_notifications_count = current_user.unread_users_notifications.count

    respond_with @users_notifications_count
  end

  def mark
    @users_notification = current_user.unread_users_notifications.find(params[:id])
    @users_notification.update(viewed: true)

    if current_user.unread_users_notifications.count <= 20
      render nothing: true, status: 200
    end
  end
end