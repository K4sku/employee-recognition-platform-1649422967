module Admins
  class OrdersController < BaseController
    def index
      @orders = Order.all.includes(:employee, :reward).order(status: :asc)
    end

    def deliver
      order.delivered!
      OrderMailer.with(order: order).order_delivered_email.deliver_later
      redirect_back fallback_location: admins_orders_path
    end

    def csv_export
      send_data Order.to_csv, filename: "orders-#{Time.zone.today}.csv"
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end
  end
end
