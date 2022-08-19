module Admins
  class CategoryPolicy < ApplicationPolicy
    def destroy?
      @record.rewards.none?
    end
  end
end
