class UserPolicy < ApplicationPolicy

  def update_or_destroy?
    record.id == user.id || user.admin?
  end

end