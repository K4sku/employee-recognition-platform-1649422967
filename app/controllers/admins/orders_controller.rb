module Admins
  class OrdersController < BaseController
    def index
      @orders = Order.all.includes(:employee, :reward).order(status: :asc)
    end

    def deliver
      order.delivered_status!
      redirect_back fallback_location: admins_orders_path
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end
  end
end
