module Notifications
  class Notification < ActiveRecord::Base
    belongs_to :event

    has_one :post, through: :event

    has_many :users_notifications
    has_many :users, through: :users_notifications

    validates :event, :message, presence: true

    after_commit :create_users_notifications, on: :create

    protected

    def create_users_notifications
      UsersNotification.create!(user: post.guru, notification: self) if event.becoming_guru?
    end
  end
end
