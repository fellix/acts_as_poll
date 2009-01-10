module <%= camel_name %>Helper
	def poller(poll)
		render(:partial => "shared/poll", :poll => poll)		
	end
end
