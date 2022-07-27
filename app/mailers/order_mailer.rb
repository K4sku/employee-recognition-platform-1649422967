class OrderMailer < ApplicationMailer
  def order_delivered_email
    @order = params[:order]
    @employee = @order.employee
    mail(to: @employee.email, subject: 'Your order has been delivered!')
  end
end
