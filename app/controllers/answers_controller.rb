class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

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
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.question = Question.find params[:question_id]
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
      # if params[:correct_answer] #radio button selection update
      #   @answer = Answer.find(params[:correct_answer].to_i)
      #   @answer.question.answers.each do |answer|
      #     if answer.id == params[:correct_answer].to_i
      #       answer.correct = true
      #     end
      #       answer.correct = false
      #   end
      #   redirect_to question_path(@answer.question)
      # else #regular update
        if @answer.update(answer_params)
          redirect_to question_path(@answer.question)
        else
          render :edit
        end
      # end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      if params[:correct_answer]
      else
        @answer = Answer.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:body, :correct_answer, :question_id)
    end

    def authorize_user!
      if params[:correct_answer]
      else
        unless can?(:crud, @answer)
            flash[:danger] = "Access Denied"
            redirect_to question_path(@answer.question.id)
        end
      end
    end
end
