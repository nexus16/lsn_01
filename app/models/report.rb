class Report < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user, presence: true
  validates :question, presence: true
  validates :content, presence: true

  scope :order_new_reports, ->{order created_at: :desc}
end
