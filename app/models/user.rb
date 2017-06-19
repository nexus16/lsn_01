class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: :facebook
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :reporting, through: :reports, source: :question
  has_many :votes, dependent: :destroy
  has_many :questions_voted, through: :votes, source: :votable,
    source_type: Question.name
  has_many :answers_voted, through: :votes, source: :votable,
    source_type: Answer.name
  mount_uploader :avatar, PictureUploader
  scope :hot_user, ->{(order vote_count: :DESC).limit 5}
  scope :order_most_voted, ->{order vote_count: :desc}

  def reporting? question
    reporting.include? question
  end

  def self.from_omniauth auth
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.username = auth.info.name
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
end
end
