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
    # @score.points = 0
    
    

    # @score = Score.new 
    # @quiz = @score.quiz params[:id]
    # @score.quiz_id = 
  end



  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new
    @score.results = params
    @score.user = current_user
    @quiz = Quiz.find params[:quiz_id]
    @score.quiz_id = params[:quiz_id]
    if @score.save

    #this saves the student's answers
    # render json: params
    #then...redirect to score#show
      redirect_to quiz_score_path(@quiz, @score)
    else
      puts @score.errors.full_messages
      redirect_to root_path
    end

    

    
    # @score = Score.create
    # puts @score.quiz_id
  end


  def show
    ######################################
    @score = Score.find(params[:id])

    @score.user = current_user
    @quiz = Quiz.find(@score.quiz_id)
#####################################################
    @questions = Quiz.find(@score.quiz_id).questions
    # @answers = @questions.answers
    
    
    #Using the student's answer's id to query the Quiz->QUestion->Answer
    
    
    #Find the students' answers for a particular quiz
    #Find the correct answers for that particular quiz

    #Compare the above
    

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit!
    end
end
