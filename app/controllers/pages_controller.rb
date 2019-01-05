class PagesController < ApplicationController
  before_action :set_categories_filters

  def show
    @page = Page.find(params[:page])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
