class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def reviews
    if current_user
      @reviews = current_user.reviews
    else
      redirect_access(root_path)
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.access = true
    @user.role = 'user'

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: "Welcome, #{current_user.name}" }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    data = current_user.role == 'admin' ? admin_params : user_params

    respond_to do |format|
      if @user.update(data)
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
    if current_user.role == 'admin'
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_access(root_path)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if current_user
      find_id = current_user.role == 'admin' ? params[:id] : current_user.id
      @user = User.find(find_id)
    else
      redirect_to root_path
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def admin_params
    params.require(:user).permit(:name, :email, :password, :access)
  end
end
