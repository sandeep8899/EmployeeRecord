class UserDetailsController < ApplicationController
	def new
		@user_details=UserDetail.new
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

	private
		def user_detail_params
			params.require(:user_detail).permit(:name , :fathers_name , :address , :gender)
		end
end
