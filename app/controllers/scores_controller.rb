class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all.where("user_id = #{current_user}")
  end

  # GET /scores/1
  # GET /scores/1.json
  # def show
  # end

  # GET /scores/new
  def new
    @score = Score.new
    @quiz = Quiz.find params[:quiz_id]
    @questions = @quiz.questions
    @score.points = 0
    
    

    # @score = Score.new 
    # @quiz = @score.quiz params[:id]
    # @score.quiz_id = 
  end



  # POST /scores
  # POST /scores.json
  def create
    @score = Score.create

    puts @score
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:quiz_id)
    end
end
