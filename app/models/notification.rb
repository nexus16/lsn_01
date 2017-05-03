class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  belongs_to :vote

  scope :noti_not_seen, ->{where seen: false}
  scope :order_new_notifications, ->{order created_at: :desc}
end
