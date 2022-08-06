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
    (Time.current - @record.created_at).floor < 60 * 5
  end
end
