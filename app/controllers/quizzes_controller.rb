class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = Quiz.all.order(created_at: :desc)

  end

  def show
  end

  def new
    @quiz = Quiz.new
  end

  def edit
  end

  def create
    @quiz = Quiz.new quiz_params
        @quiz.user = current_user
        if can? (:create)
            @quiz.save
            flash[:primary] = "Thanks for your new quiz!"
            redirect_to quiz_path(@quiz.id)
        else
            render :new 
        end
    
  end

  def update
    @quiz = Quiz.find params[:id]
        if @quiz.update quiz_params
            flash[:primary] = "Thanks for updating your quiz!"
            redirect_to quiz_path(@quiz.id)
        else 
            render :edit
        end
  end

  def destroy
    @quiz = Quiz.find params[:id]
    @quiz.destroy
    flash[:primary] = "We're sorry to see that you deleted your quiz."
    redirect_to root_path
  end

  private
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:name)
    end
end
