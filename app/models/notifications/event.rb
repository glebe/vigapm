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
      self.create!(post: post, message: "Congratulations! You are now a Guru on #{post.title}!", kind: :becoming_guru)
    end

    def self.notify_post_commented!(post, commentator)
      self.create!(post: post, message: %[#{commentator.username} wrote a new comment on #{post.title}.], kind: :post_commented)
    end

    def self.notify_post_edited!(post)
      self.create!(post: post, message: %[#{post.guru} has updated #{post.title}.], kind: :post_edited)
    end

    protected

    def create_notification
      Notifications::Notification.create!(event: self, message: message)
    end
  end
end
