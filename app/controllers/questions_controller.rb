class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  # before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  # GET /questions/1
  def show
    @answers = @question.answers.order(created_at: :desc)
  end

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
      redirect_to quiz_questions_path(@question.quiz)
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
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
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
