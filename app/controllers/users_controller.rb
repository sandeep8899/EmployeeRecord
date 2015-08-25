class UsersController < ApplicationController

	before_action :check_details

	def index
		@users=User.all
	end

	def show
		@user=User.find(params[:id])
	end

	def check_details
		unless User.last.user_detail
			redirect_to new_user_details_path
		end
	end
end
