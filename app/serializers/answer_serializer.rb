class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :correct
  has_one :question
end
