module ApplicationHelper
  def language_direction
    I18n.locale != :ar ? "ltr" : "rtl"
  end
end
