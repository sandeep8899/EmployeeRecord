class UsersController < ApplicationController

	#before_action :check_details , only: [:index , :show]

	# def check_login
	# 	if user_signed_in?
	# 		byebug
	# 		if current_user.user_type == 'user'
	# 			redirect_to members_home_path
	# 		else
	# 			redirect_to users_path
	# 		end	
	# 	else
	# 		redirect_to new_user_session_path
	# 	end
	# end

	def index
		#byebug
		if user_signed_in?
			if current_user.user_type == 'User'
				#byebug
				redirect_to members_home_path
			else
				#byebug
				@users=User.includes(:user_detail).where(user_type: 'user')
				render 'index'
			end
		else
			redirect_to new_user_session_path
		end

		# check_login
		#@users=User.joins(:user_detail).where(:user_details=>{ user_type: 'user' }).all
		
	end

	def show
		@user=User.find(params[:id])
	end

	def members_home
		#@user_history=
		#byebug
		# check_login
		if user_signed_in?
			if current_user.user_type == 'User'
				datetime=Time.now
				@date=datetime.day.to_s + "/" + datetime.month.to_s + "/" + datetime.year.to_s
				time=datetime.hour.to_s+ ":" + datetime.min.to_s
				render 'members_home'
			else
				redirect_to users_path
			end
		else
			redirect_to new_user_session_path
		end
	end

	def punch
		datetime=Time.now
		date=datetime.day.to_s + "/" + datetime.month.to_s + "/" + datetime.year.to_s
		# time=datetime.hour.to_s+ ":" + datetime.min.to_s
		#byebug
		if params[:in].nil?
			check=History.where(date: date , user_detail_id: current_user.user_detail.user_id).count
			if check == 1
				time=params[:out]
				@history=History.where(date: date , user_detail_id: current_user.user_detail.user_id)
				byebug
				@history.out_time=time
				if @history.save
					redirect_to members_home_path , notice: 'Your attendence for today has marked... Thankyou...'
				else
					render 'members_home' , notice: 'some technical error occured... Thankyou...'
				end
			else
				redirect_to members_home_path , notice: 'Your attendence for in time already marked... Thankyou...'
			end

		else
			check=History.where(date: date , user_detail_id: current_user.user_detail.user_id).count
			if check == 0
				byebug
				time=params[:in]
				@history=History.new(date: date, in_time: time )
				@history.user_detail_id=current_user.user_detail.user_id
				if @history.save
					redirect_to members_home_path , notice: 'Your attendence for today has marked... Thankyou...'
				else
					render 'members_home' , notice: 'some technical error occured... Thankyou...'
				end
			else
				redirect_to members_home_path , notice: 'Your attendence for in time already marked... Thankyou...'
			end

		end
		
		
		# else
		# 	render 'members_home' , notice: 'Your attendence for today already marked... Thankyou...'
		# end
	end

	def check_details
		check_login
		unless User.last.user_detail
			redirect_to new_user_details_path
		end
	end
end
