class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :quiz
end
