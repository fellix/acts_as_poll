class PollGenerator < Rails::Generator::NamedBase
	attr_accessor :model_name
	
	def initialize(args, options = {})
		super 
		@model_name = args[0]
	end
	
	def manifest
		record do |m| 
			m.migration_template "#{@model_name}_migration.rb.erb",
														File.join("db", "migrate"),
														:migration_file_name => "create_#{@model_name}"
			m.migration_template "#{@model_name}_option_migration.rb.erb",
														File.join("db", "migrate"),
														:migration_file_name => "create_#{@model_name}_option"
			m.template "poll.rb.erb", File.join("app/models/", "#{@model_name}.rb")
			m.template "poll_option.rb.erb", File.join("app/models/", "#{@model_name}_option.rb")
		end
	end
	
end
