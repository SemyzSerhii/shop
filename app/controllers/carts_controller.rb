class CartsController < InheritedResources::Base
  before_action :set_categories_filters

  private

    def cart_params
      params.require(:cart).permit(:user_id)
    end
end

