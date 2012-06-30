module HomeHelper
  def field_content(field_id)
    RedCloth.new(session[field_id].to_s).to_html.html_safe
  end
end
