class Quiz < ApplicationRecord
  belongs_to :user
  has_many :scores
  has_many :users, through: :scores
  has_many :questions
end
