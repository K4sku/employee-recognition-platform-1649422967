# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview
  def order_delivered_email
    order = Order.first
    OrderMailer.with(order: order).order_delivered_email
  end
end
