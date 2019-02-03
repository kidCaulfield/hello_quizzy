class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
      # if user.admin?
      #   can :manage, :all
      # else
      #   can :read, :all
      # end
    #


    alias_action(:read, :create, :edit, :update, :delete, :destroy, to: :crud)


    can(:crud, Quiz) do |quiz|
      quiz.user == user
    end

    can(:crud, Question) do |question|
      question.user == user
    end

    can(:crud, Answer) do |answer|
      answer.user == user
    end

    can(:crud, User) do |user|
      user == user
    end
  end
end
