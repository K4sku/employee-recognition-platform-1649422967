class OrdersController < EmployeeBaseController
  def create
    reward = Reward.find(params[:reward])
    if current_employee.points < reward.price
      redirect_to reward_path(reward),
                  alert: 'Not enough points for this reward' and return
    end

    @order = Order.new(reward_id: order_params)
    @order.employee = current_employee
    if @order.save
      redirect_to rewards_path, notice: 'You have bought a reward!'
    else
      flash[:notice] = 'Something went wrong'
      redirect_back
    end
  end

  private

  def order_params
    params.require(:reward)
  end
end
