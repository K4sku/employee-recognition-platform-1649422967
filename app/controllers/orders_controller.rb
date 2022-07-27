class OrdersController < EmployeeBaseController
  def index
    @orders = Order.where(employee: current_employee).includes(:reward)
    @orders = @orders.delivered if order_params[:status] == 'delivered'
    @orders = @orders.placed if order_params[:status] == 'not_delivered'
  end

  def create
    reward = Reward.find(order_params[:reward_id])
    @order = Order.new(reward: reward, employee: current_employee, purchase_price: reward.price, status: :placed)
    if order.save
      redirect_to rewards_path, notice: 'You have bought a reward!'
    else
      flash[:alert] = order.errors[:can_not_afford].join('. ')
      redirect_back fallback_location: rewards_path
    end
  end

  private

  def order_params
    params.permit(:reward_id, :status)
  end

  def order
    @order ||= Order.find(params[:order_id])
  end
end
