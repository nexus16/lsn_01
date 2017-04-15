class Question < ApplicationRecord
  searchkick highlight: [:title, :content], suggest: [:title]

  belongs_to :category
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :reporters, through: :reports, source: :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  acts_as_taggable

  scope :hot_questions, ->{(order vote_count: :DESC).limit 5}
  scope :order_new_questions, ->{order created_at: :desc}
  scope :order_vote_questions, ->{order vote_count: :desc}
  scope :order_DESC, ->{order created_at: :desc}

  def search_data
    as_json only: [:title, :content]
    {
      title: title,
      content: content
    }
  end
end

Question.reindex
