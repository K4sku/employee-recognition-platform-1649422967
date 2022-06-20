class OrdersController < EmployeeBaseController
  def index
    @orders = Order.where(employee: current_employee).includes(:reward)
  end

  def create
    @order = Order.new(reward_id: order_params)
    order.employee = current_employee
    order.set_purchase_price
    if order.save
      redirect_to rewards_path, notice: 'You have bought a reward!'
    else
      flash[:alert] = order.errors[:can_not_afford].join('. ')
      redirect_back fallback_location: rewards_path
    end
  end

  private

  def order_params
    params.require(:reward_id)
  end

  def order
    @order ||= Order.find(params[:order_id])
  end
end
