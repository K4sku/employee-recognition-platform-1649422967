module Admins
  class OrdersController < BaseController
    def index
      @orders = Order.all.includes(:employee, :reward).order(status: :desc)
      @undelivered_orders_count = count_undelivered
    end

    def deliver
      authorize!
      order.delivered_status!
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
