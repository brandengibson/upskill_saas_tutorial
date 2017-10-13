class ContactsController < ApplicationController

  # GET request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # Post request /contacts
  def create
    # Mass assignment of form fields into contact object
    @contact = Contact.new(contact_params)
    # Save the contact object to database
    if @contact.save
      # store form fields via params into vars.
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into Contact Mailer 
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # store success message and flash hash
      # and redirect to new action
      flash[:success] = "Message Sent"
       redirect_to new_contact_path
    else
      # if contact object does not save,
      # store error in flash hash
      # redirect to new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end
  end
  
  private
  # To collect data from form, we need to use
  # strong parameters and whitelist the form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end