class Answer < ApplicationRecord
  after_save :create_notification

  belongs_to :question
  belongs_to :user

  has_many :votes, as: :votable, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  has_many :notifications

  scope :order_new_answers, ->{order created_at: :desc}
  scope :order_vote_answers, ->{order vote_count: :desc}
  scope :answers_by_time, ->begin_date, end_date{select("id").joins(:votes)
    .where("votes.created_at BETWEEN ? AND ?",
    begin_date, end_date).group("answers.id")}
  has_closure_tree

  def create_notification
    to_notify = [question.user] + question.answer_users
    to_notify = to_notify.uniq
    to_notify.delete user
    to_notify.each do |notification_to_user|
      notifications.create(
        user: notification_to_user,
        question: question,
        answer: self,
        seen: false
        )
    end
  end

end
