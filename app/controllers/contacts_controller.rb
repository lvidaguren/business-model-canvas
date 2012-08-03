class ContactsController < ContactUs::ContactsController
  def create
    @contact = ContactUs::Contact.new(params[:contact_us_contact])
    
    if verify_recaptcha(model: @contact, message: t('contact_us.notices.captcha_error'), timeout: 30) && @contact.save
      flash.delete(:recaptcha_error)
      redirect_to('/', notice: t('contact_us.notices.success'))
    else
      flash.delete(:recaptcha_error)
      flash[:error] = t('contact_us.notices.error')
      render_new_page
    end
  end

  def new
    @contact = ContactUs::Contact.new
    render_new_page
  end

  protected

  def render_new_page
    case ContactUs.form_gem
    when 'formtastic'  then render 'new_formtastic'
    when 'simple_form' then render 'new_simple_form'
    else
      render 'new'
    end
  end
end