class UsersNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification, class_name: Notifications::Notification
  has_one :sender, through: :notification

  after_commit :send_email_to_user!, on: :create

  protected

  # TODO: implement email notification
  def send_email_to_user!
    send_email_to_user?
  end

  def send_email_to_user?
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(
      user.public_send(%[notify_#{notification.event.kind}]))
  end
end
