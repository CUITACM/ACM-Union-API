class UserPolicy < ApplicationPolicy

  def create?
    true
  end

  def update?
    record.id == user.id || user.admin?
  end
end