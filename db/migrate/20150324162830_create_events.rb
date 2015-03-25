class CreateEvents < ActiveRecord::Migration
  def change
    enable_extension 'hstore'

    change_table :users do |t|
      t.hstore :notification_settings
    end

    User.find_each do |user|
      user.notify_becoming_guru = true
      user.notify_post_commented = true
      user.notify_post_edited = true
      user.save
    end

    create_table :events, force: true do |t|
      t.integer :kind
      t.belongs_to :post, index: true
    end

    create_table :notifications do |t|
      t.belongs_to :event, index: true
      t.string :message
    end

    create_table :users_notifications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :notification, index: true
      t.boolean :viewed, default: false, null: false
    end

    add_index :users_notifications, %i(user_id notification_id)
  end
end
