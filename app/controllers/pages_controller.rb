class PagesController < ApplicationController
  before_action :set_categories_filters

  include CurrentCart
  before_action :set_cart

  def show
    @page = Page.find(params[:page])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
