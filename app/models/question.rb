class Question < ApplicationRecord
  searchkick highlight: [:title, :content], suggest: [:title, :content],
    word_start: [:title, :content]

  belongs_to :category
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :reporters, through: :reports, source: :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  has_many :answer_users, -> {distinct}, through: :answers, source: :user
  has_many :notifications

  acts_as_taggable

  scope :hot_questions, ->{(order vote_count: :DESC).limit 5}
  scope :order_new_questions, ->{order created_at: :desc}
  scope :order_vote_questions, ->{order vote_count: :desc}
  scope :order_DESC, ->{order created_at: :desc}
  scope :questions_by_time, ->begin_date, end_date{joins(:votes)
    .where("votes.created_at BETWEEN ? AND ?", begin_date, end_date)
    .group("questions.id")}

  def search_data
    as_json only: [:title, :content]
    {
      title: title,
      content: content
    }
  end
end

Question.reindex
