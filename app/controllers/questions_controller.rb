class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /questions/1
  def show
    @answers = @question.answers.order(created_at: :desc)
    # def current_check(answer) #method for radio buttons on answers
    #   answer.correct ? true : false
    # end
  end
  # helper_method :current_check

  # GET /questions/new
  def new
    @quiz = Quiz.find params[:quiz_id]
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.quiz = Quiz.find params[:quiz_id]
    
    if @question.save question_params
      flash[:success] = "Question created"
      redirect_to quiz_path(@question.quiz)
    else
      flash[:danger] = "There appear to be some errors."
      render 'questions/new'
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update question_params
      redirect_to question_path(@question.id)
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    flash[:danger] = "Question has been deleted"
    redirect_to quiz_path(@question.quiz)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:body, :quiz_id)
    end

    def find_question
      @question = Question.find params[:id]
    end

    def authorize_user!
      unless can?(:crud, @question)
          flash[:danger] = "Access Denied"
          redirect_to question_path(@question.id)
      end
    end
end
