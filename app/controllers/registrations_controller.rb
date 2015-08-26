class RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(resource)
  	go_there
  end

  def after_sign_up_path_for(resource)
  	go_there
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def go_there
  	if current_user.user_type=='Admin'
    	users_path
    else
    	members_home_path
    end
  end
end