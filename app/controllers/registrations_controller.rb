class RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(resource)
  	byebug
  	if current_user.user_type=='admin'
    	users_path
    else
    	members_home_path
  end
end