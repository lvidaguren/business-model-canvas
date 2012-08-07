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
  
  def alert_type(key)
    case key
    when :notice
      'success'
    when :error
      'danger'
    else
      key
    end
  end
  
  def current_host
    if Rails.env == 'production'
      'http://businessmodelcanvas.herokuapp.com'
    else
      'http://localhost:3000'
    end
  end
  
  def download_params_for(type)
    if URI(url_for(ony_path: false)).path.include?('sections')
      {type: type, file: 'section', section_name: params[:handler]}
    else
      {type: type, file: 'show'}
    end
  end
end