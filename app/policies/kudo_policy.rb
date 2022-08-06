class KudoPolicy < ApplicationPolicy
  def update?
    giver?
  end

  def edit?
    update?
  end

  def destroy?
    giver?
  end

  def giver?
    @record.giver == @user
  end
end
