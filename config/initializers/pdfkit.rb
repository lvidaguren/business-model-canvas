PDFKit.configure do |config|       
  config.wkhtmltopdf = if Rails.env.production?
    "#{Rails.root}/wkhtmltopdf-amd64"  
  else
    "#{Rails.root}/wkhtmltopdf-i386"  
  end
end  