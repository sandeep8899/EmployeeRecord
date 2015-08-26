class UsersController < ApplicationController

	before_action :check_details

	def index
		#@users=User.joins(:user_detail).where(:user_details=>{ user_type: 'user' }).all
		@users=User.includes(:user_detail).where(user_type: 'user')
	end

	def show
		@user=User.find(params[:id])
	end

	def members_home
		#@user_history=
	end

	def punch
		datetime=Time.now
		date=datetime.day.to_s + "/" + datetime.month.to_s + "/" + datetime.year.to_s
		time=datetime.hour.to_s+ ":" + datetime.min.to_s
		check=History.where(date: date , user_detail_id: current_user.user_detail.user_id).count
		#byebug
		if check==0
			#byebug
			history=History.new(date: date, time: time )
			history.user_detail_id=current_user.user_detail.user_id
			if history.save
				redirect_to members_home_path
			else
				render 'members_home'
			end
		else
			render 'members_home'
		end
	end

	def history
		@histories=History.where(user_detail_id: params[:id])
	end

	def check_details
		unless User.last.user_detail
			redirect_to new_user_details_path
		end
	end
end
