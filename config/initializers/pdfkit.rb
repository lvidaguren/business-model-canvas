PDFKit.configure do |config|       
  config.wkhtmltopdf = if Rails.env.production?
    "#{Rails.root}/bin/wkhtmltopdf-amd64"  
  else
    "#{Rails.root}/bin/wkhtmltopdf-i386"  
  end
end  