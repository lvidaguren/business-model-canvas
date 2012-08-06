IMGKit.configure do |config|
  config.wkhtmltoimage =  if Rails.env == 'production'
    "#{Rails.root}/wkhtmltoimage-amd64"  
  else
    "#{Rails.root}/wkhtmltoimage-i386"  
  end
end

