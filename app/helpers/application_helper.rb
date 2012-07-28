module ApplicationHelper
  def language_direction
    I18n.locale != :ar ? "ltr" : "rtl"
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def resource_class
    devise_mapping.to
  end
end