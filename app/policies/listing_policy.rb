class ListingPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private_listing || current_account == record.account
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    current_account == record.account
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

   # AASM Events
  def publish?
    
  end

  def stop?
    
  end

  def start?
    
  end

  def close?
    
  end

  def open?
    
  end
end