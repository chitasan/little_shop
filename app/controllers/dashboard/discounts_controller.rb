class Dashboard::DiscountsController < Dashboard::BaseController
  def index
    @items = current_user.items.where(active: true)
  end

  
end 