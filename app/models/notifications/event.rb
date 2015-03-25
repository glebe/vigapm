module Notifications
  class Event < ActiveRecord::Base
    include ActionView::Helpers::UrlHelper

    EVENT_TYPES = %i(becoming_guru post_commented post_edited)

    attr_accessor :message

    belongs_to :post
    belongs_to :user
    has_many :notifications

    validates :post, :user, presence: true

    enum kind: EVENT_TYPES

    after_commit :create_notification, on: :create
    after_validation :assign_message, on: :create

    def self.notify_becoming_guru!(post)
      self.create!(user: post.guru,
                   post: post,
                   kind: :becoming_guru)
    end

    def self.notify_post_commented!(post, commentator)
      self.create!(user: commentator,
                   post: post,
                   kind: :post_commented)
    end

    def self.notify_post_edited!(post)
      self.create!(user: post.guru,
                   post: post,
                   kind: :post_edited)
    end

    protected

    def create_notification
      Notifications::Notification.create!(event: self, message: message)
    end

    def assign_message
      self.message = send(:"#{kind}_message")
    end

    def post_commented_message
      sprintf '%s wrote a new comment on %s', link_to_user, link_to_post
    end

    def becoming_guru_message
      sprintf 'Congratulations! You are now a Guru on %s', link_to_post
    end

    def post_edited_message
      sprintf '%s has updated %s', link_to_user, link_to_post
    end

    def link_to_user
      link_to(user.username, Rails.application.routes.url_helpers.user_path(user))
    end

    def link_to_post
      link_to(post.title, Rails.application.routes.url_helpers.post_path(post))
    end
  end
end
