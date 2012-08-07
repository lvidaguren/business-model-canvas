IMGKit.configure do |config|
  config.wkhtmltoimage =  if Rails.env == 'production'
    "#{Rails.root}/bin/wkhtmltoimage-amd64"  
  else
    "#{Rails.root}/bin/wkhtmltoimage-i386"  
  end
end

