class Ability
  include CanCan::Ability

  def initialize(user)
   
    user ||= User.new

    alias_action(:read, :create, :edit, :update, :delete, :destroy, to: :crud)

    can(:crud, Quiz) do |quiz|
      quiz.user == user
    end

    can(:crud, Question) do |question|
      question.quiz.user == user
    end

    can(:crud, Answer) do |answer|
      answer.question.quiz.user == user
    end

    can(:crud, User) do |user|
      user == user
    end
  end
end
