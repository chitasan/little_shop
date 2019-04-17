class Dashboard::DashboardController < Dashboard::BaseController
  def index
    @merchant = current_user
    @pending_orders = Order.pending_orders_for_merchant(current_user.id)
    @unfulfilled_count = @merchant.unfulfilled_orders_count
    @unfulfilled_revenue = @merchant.unfulfilled_orders_revenue
    @default_image_items = @merchant.default_image_items

  end
end