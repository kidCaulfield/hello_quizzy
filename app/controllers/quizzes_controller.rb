class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  

  def index
    @quizzes = Quiz.all.order(created_at: :desc)
  end

  def show
    # Check within the view to determine who is the 
    @questions = @quiz.questions
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
          # you're NOT signed in
          flash[:danger] = "You are not signed in"
          redirect_to new_session_path
    end
  end

  def new
    if current_user.educator == true
      @quiz = Quiz.new
    else
      flash[:danger] = "Access Denied"
      redirect_to quizzes_path
    end
  end

  def edit
  end

  def create
    @quiz = Quiz.create quiz_params
    @quiz.user = current_user
      # if can? (:create)
    if @quiz.save
      flash[:primary] = "You've created a new quiz! Hello, Quizzy!"
      redirect_to quiz_path(@quiz.id)
      # redirect_to quizzes_path
    else
      flash[:danger] = "Something went wrong. Please review the page below."
      render 'quizzes/new'
    end
  end

  def update
    @quiz = Quiz.find params[:id]
        if @quiz.update quiz_params
            flash[:primary] = "Thanks for updating your quiz!"
            redirect_to quiz_path(@quiz)
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
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:name, :description, :published)
    end

    def authorize_user!
      unless can?(:crud, @quiz)
          flash[:danger] = "Access Denied"
          redirect_to quizzes_path
      end
    end
  end