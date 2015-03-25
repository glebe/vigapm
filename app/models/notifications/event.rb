module Notifications
  class Event < ActiveRecord::Base
    EVENT_TYPES = %i(becoming_guru post_commented post_edited)

    attr_accessor :message

    belongs_to :post
    has_many :notifications

    validates :post, presence: true

    enum kind: EVENT_TYPES

    after_commit :create_notification, on: :create

    def self.notify_becoming_guru!(post)
      self.create!(post: post, message: "Congratulations! You are now a Guru on #{title}!")
    end

    protected

    def create_notification
      Notifications::Notification.create!(event: self, message: message)
    end
  end
end
