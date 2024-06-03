class RegistrationsController < Devise::RegistrationsController
  def destroy
    flash[:alert] = "You cannot delete your account."
    redirect_to root_path
  end
end
