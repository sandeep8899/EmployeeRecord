class HistoriesController < ApplicationController

	before_action :check_login

	def check_login
		unless user_signed_in?
			new_user_session_path			
		end
	end

	def show
		@histories=History.where(user_detail_id: params[:id])
	end

end
