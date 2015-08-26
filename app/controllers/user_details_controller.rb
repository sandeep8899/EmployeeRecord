class UserDetailsController < ApplicationController

	before_action :check_login

	def check_login
		unless user_signed_in?
			new_user_session_path			
		end
	end

	def new
		@user_detail=UserDetail.new
	end

	def create
		@user_details=UserDetail.new(user_detail_params)
		@user_details.user=current_user
		if @user_details.save
			redirect_to members_home_path
		else
			render 'new'
		end
	end

	def edit
		@user_detail=User.find(params[:id]).user_detail
		#byebug
	end

	def update
		@user_detail=UserDetail.find(params[:id])
		if @user_detail.update_attributes(user_detail_params)
			redirect_to members_home_path
		else
			render 'edit'
		end
	end

	private
		def user_detail_params
			params.require(:user_detail).permit(:name , :fathers_name , :address , :gender , :contact_number , :emergency_contact_number , :date_of_joining)
		end
end
