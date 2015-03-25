class UsersNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification, class_name: Notifications::Notification
end
