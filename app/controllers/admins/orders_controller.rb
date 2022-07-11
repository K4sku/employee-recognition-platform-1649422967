module Admins
  class OrdersController < BaseController
    def index
      @orders = Order.all.includes(:employee, :reward).order(status: :asc)
      @undelivered_orders_count = count_undelivered
    end

    def deliver
      authorize!
      order.delivered_status!
      redirect_back fallback_location: admins_orders_path
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end

    def authorize!
      raise AuthorizationError unless admin_signed_in?
    end

    def count_undelivered
      @orders.count { |order| order.status != 'delivered' }
    end
  end
end
