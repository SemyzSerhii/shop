require 'active_admin/base_controller'
ActiveAdmin::BaseController.class_eval do
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors
  def show_errors
    redirect_to admin_root_path, alert: 'The page you were looking for does not exist (404).'
  end
end
