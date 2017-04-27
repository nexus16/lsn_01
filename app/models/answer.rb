class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many :votes, as: :votable, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  scope :order_new_answers, ->{order created_at: :desc}
  scope :order_vote_answers, ->{order vote_count: :desc}
  scope :answers_by_time, ->begin_date, end_date{select("id").joins(:votes)
    .where("votes.created_at BETWEEN ? AND ?",
    begin_date, end_date).group("answers.id")}

  has_closure_tree
end
