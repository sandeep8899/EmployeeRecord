module HistoriesHelper
	def change_time(time)
		# t=time
	    local_time = time.in_time_zone('Chennai')
	    # desired_time = local_time-local_time.utc_offset
	    time=local_time.hour.to_s+":"+local_time.min.to_s
    end 
end
