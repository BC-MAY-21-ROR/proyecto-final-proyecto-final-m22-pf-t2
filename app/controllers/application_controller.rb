class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def current_user_owns_current_business
    return false if current_user.owned_business.nil?

    current_business_id == current_user.owned_business.id
  end

  def current_business
    Business.find_by_id(current_business_id)
  end

  def current_business=(business)
    self.current_business_id = business.id
  end

  def current_business_id
    session[:business_id]
  end

  def current_business_id=(business_id)
    session[:business_id] = business_id
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_business)
  end
end
