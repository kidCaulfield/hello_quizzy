class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
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

    if @user.save user_params
      redirect_to root_path
    else
      render 'users/new'
    end
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.new(user_params)

    if @user.update user_params
      session[:user_id] = @user.id
      flash[:primary] = "Thanks, #{@user.first_name} for signing up!"
            redirect_to root_path
        else
            render "users/new"
        end
  end

  # DELETE /users/:id
  def destroy
    user = User.new(user_params)
    user.destroy
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :educator)
    end
end
