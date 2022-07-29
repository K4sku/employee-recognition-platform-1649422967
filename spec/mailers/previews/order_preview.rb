# Preview all emails at http://localhost:3000/rails/mailers/order
# loads FactoryBot to use build strategy
class OrderPreview < ActionMailer::Preview
  include FactoryBot::Syntax::Methods

  def order_delivered_email
    order = build(:order)
    OrderMailer.with(order: order).order_delivered_email
  end
end
