class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = Quiz.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    # Check within the view to determine who is the 
  end

  def new
    @quiz = Quiz.new
  end

  def edit
  end

  def create
    @quiz = Quiz.new quiz_params
        @quiz.user = User.first#current_user
        # if can? (:create)


        if @quiz.save quiz_params
            flash[:primary] = "Hello, Quizzy!"
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
    quiz = Quiz.find params[:id]
    quiz.destroy
    flash[:primary] = "Goodbye, Quizzy!"
    redirect_to root_path
  end

  private

  def authorize_user!
    unless can?(:crud, @quiz)
      flash[:danger] = "Access Denied"
      redirect_to quiz_path(@quiz)
    end
  end
  
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:name)
    end
end
