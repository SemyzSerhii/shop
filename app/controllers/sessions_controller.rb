class SessionsController < ApplicationController
  before_action :set_categories_filters

  include CurrentCart
  before_action :set_cart

  def create
    @user = User.find_by_name(params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @cart.update_columns(user_id: current_user.id) if @cart.line_items.present?
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
