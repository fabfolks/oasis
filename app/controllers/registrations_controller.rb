class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:notice] = 'Registration is reserved to admin. Contact nsready@gmail.com'
    redirect_to root_path
  end

  def create
    flash[:notice] = 'Registration is reserved to admin. Contact nsready@gmail.com'
    redirect_to root_path
  end
end
