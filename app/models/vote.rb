class Vote < ApplicationRecord
  after_save :create_notification

  belongs_to :user
  belongs_to :votable, polymorphic: true

  has_many :notifications

  enum vote_type: {positive: 1, negative: -1}

  def create_notification
    if self.votable_type == "Question"
      notifications.create(
        user: votable.user,
        question: votable,
        vote: self,
        seen: false
      )
    else
      notifications.create(
        user: votable.user,
        question: votable.question,
        vote: self,
        seen: false
      )
    end
  end
end
