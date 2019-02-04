class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  # GET /users
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /users/1
  def show
    @user_quizzes = @user.quizzes.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/:id/edit
  def edit
    @user = User.find params[:id]
  end

  # POST /users
  def create
    @user = User.new(user_params)
      if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Hello Quizzy, #{@user.username}"
      redirect_to quizzes_path
    else
      render :new
    end
  end

  def new
      @user = User.new
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.new(user_params)

    if @user.update(user_params)
      flash[:succes] = "Your Account was updated Successfully"
      redirect_to quizzes_path
    else
      render 'edit'
    end
      
  end

  def my_scores
    # users make scores
    @user = current_user
    @score_history = @user.scores.order(created_at: :desc)
  end

  def my_quizzes
    @user = current_user
    @quizzes_made = @user.quizzes.order(created_at: :desc)
  end


  private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user
        flash[:danger] = "You can only Edit your own Account"
        redirect_to root_path
      end
    end
end
