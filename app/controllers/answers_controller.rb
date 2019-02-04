class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  # def index
  #   @answers = Answer.all
  # end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    @answer.question = Question.find params[:question_id]
  end

  # GET /answers/1/edit
  def edit
    @answer.question = Question.find params[:question_id]
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.question = Question.find params[:question_id]
    if @answer.save
      redirect_to root_path
    else
      render :new
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
      if @answer.update(answer_params)
    
      else

      end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:body, :correct, :question_id)
    end

    def authorize_user!
      unless can?(:crud, @answers)
          flash[:danger] = "Access Denied"
          redirect_to question_path(@answer.question.id)
      end
    end
end
