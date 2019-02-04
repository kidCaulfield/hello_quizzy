class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  def index
    @scores = Score.all.where("user_id = #{current_user}")
  end

  # GET /scores/new
  def new
    @score = Score.new
    @quiz = Quiz.find params[:quiz_id]
    @questions = @quiz.questions
  end



  # POST /scores
  def create
    @score = Score.new
    @score.results = params
    @score.user = current_user
    @quiz = Quiz.find params[:quiz_id]
    @score.quiz_id = params[:quiz_id]

    answers = []
    @quiz.questions.each do |question|
      answers << Answer.find(@score.results["#{question.id}"].to_i)
    end

    total_correct = answers.select{|a| a.correct == true}.size
    @score.total = (total_correct.to_f / @quiz.questions.size.to_f)*100

    if @score.save
    #this saves the student's answers
    # render json: params
    #then...redirect to score#show
      redirect_to quiz_score_path(@quiz, @score)
    else
      puts @score.errors.full_messages
      redirect_to root_path
    end
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
