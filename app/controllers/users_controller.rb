class UsersController < ApplicationController
  protect_from_forgery
  before_action :prevent_login_signup, only: [:signup, :login]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create user_params
    puts user_params
    found_user_by_username = User.where(username: params[:username]).first
    found_user_by_email = User.where(email: params[:email]).first
    if found_user_by_username or found_user_by_email
      flash[:error] = "That username or email already exists. Try something different."
      redirect_to new_user_path
    elsif @user.save
      attempt_login
      redirect_to contacts_path
    else
      flash[:error] = "Nuh uh uh. Try again."
      render :new
    end
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
          if authorized_user
            redirect_to contacts_path
          else
            flash[:notice] = "Your username or password is invalid"
            redirect_to root_path
          end
      else
        flash[:notice] = "Your username or password is invalid"
        redirect_to root_path
      end
    end
  end

  def logout
    session[:profile_id] = nil
    redirect_to root_path
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_digest, :first_name, :last_name)
    end

    def prevent_login_signup
      if session[:user_id]
        redirect_to contacts_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.

end
