class UsersController < ApplicationController

	#before_action :check_details , only: [:index , :show]

	# def check_login
	# 	if user_signed_in?
	# 		
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
		if user_signed_in?
			if current_user.user_type == 'User'
				redirect_to members_home_path
			else
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
		#
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
		if params[:in].nil?
			check=History.where(date: date , user_detail_id: current_user.user_detail.user_id).count
			if check == 1
				# time=params[:out]
				a=params[:out]
				time=Time.parse(a[:"out_time(1i)"]+"/"+a[:"out_time(2i)"]+"/"+a[:"out_time(3i)"]+" "+a[:"out_time(4i)"]+":"+a[:"out_time(5i)"])
				# time.zone = Time.now.zone
				
				@history=History.where(date: date , user_detail_id: current_user.user_detail.user_id).first
				
				if @history.out_time.nil?
					in_time=@history.in_time.in_time_zone('Chennai')
					in_time=date + " " + in_time.hour.to_s + ":" + in_time.min.to_s
					
					if time > in_time #@history.map(&:in_time)[0].to_i
						#@history.map(&:out_time)[0] = time
						
						if @history.update_attributes(:out_time=> time)
							redirect_to members_home_path , notice: 'Your attendence for today has marked... Thankyou...'
						else
							render 'members_home' , notice: 'some technical error occured... Thankyou...'
						end
					else
						redirect_to members_home_path , notice: 'you select invalid out time... Thankyou...'
					end
				else
					render 'members_home' , notice: 'your attendence for today already markded... Thankyou...'

				end
			else
				redirect_to members_home_path , notice: 'Your attendence for "in time" is not marked... Thankyou...'
			end

		else
			check=History.where(date: date , user_detail_id: current_user.user_detail.user_id).count
			if check == 0
				
				a=params[:in]
				
				time=Time.parse(a[:"in_time(1i)"]+"/"+a[:"in_time(2i)"]+"/"+a[:"in_time(3i)"]+" "+a[:"in_time(4i)"]+":"+a[:"in_time(5i)"])
				#Time.zone.local_to_utc(time)
				
				# time.zone = Time.now.zone
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
