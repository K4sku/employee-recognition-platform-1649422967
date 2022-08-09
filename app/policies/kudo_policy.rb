class KudoPolicy < ApplicationPolicy
  def update?
    giver? && less_then_5_minutes_past_creation?
  end

  def edit?
    update?
  end

  def destroy?
    giver? && less_then_5_minutes_past_creation?
  end

  def giver?
    @record.giver == @user
  end

  private

  def less_then_5_minutes_past_creation?
    @record.created_at > 5.minutes.ago
  end
end
