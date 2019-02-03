class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = Quiz.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    # Check within the view to determine who is the 
    if user_signed_in?
        #if you're teacher
        if current_user.educator == true
          # @quizzes = Quiz.all.where("user_id = 79")
          @quizzes = Quiz.all.where(`user_id = #{current_user}`)
        else
          #if you're studnet
          @quizzes = Quiz.all.where("published = true")
        end
    else 
          # you're not signed IN
          flash[:danger] = "You are not signed in"
          redirect_to new_session_path
    end
  end

  def new
    @quiz = Quiz.new
  end

  def edit
    # @quiz = Quiz.find params[:id]
  end

  def create
    @quiz = Quiz.create quiz_params
        @quiz.user = current_user
        if can? (:create)
            @quiz.save
            flash[:primary] = "Hello, Quizzy!"
            redirect_to quizzes_path
        else
            flash[:danger] = "you are not authorized because you're a student"
            render root_path
        end
  end

  def update
    # @quiz = Quiz.find params[:id]
        if @quiz.update quiz_params
            flash[:primary] = "Thanks for updating your quiz!"
            redirect_to quizzes_path
        else 
            render :edit
        end
  end

  def destroy
    @quiz = Quiz.find params[:id]
    @quiz.destroy
    flash[:primary] = "Goodbye, Quizzy!"
    redirect_to quizzes_path
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
      params.require(:quiz).permit(:name, :description, :published)
            redirect_to quizzes_path
        else
            flash[:danger] = "you are not authorized because you're a student"
            render root_path
        end
  end