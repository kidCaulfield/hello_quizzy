class User < ApplicationRecord
    has_many :scores
    has_many :quizes, through: :scores, dependent: :nullify
end
