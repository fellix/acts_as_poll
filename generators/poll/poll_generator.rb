class PollGenerator < Rails::Generator::NamedBase
	attr_accessor :base_name, :model_name, :camel_name, :plural_name
	
	def initialize(args, options = {})
		super 
		@base_name = args[0]
		@model_name = @base_name.downcase
		@camel_name = @model_name.camelize
		@plural_name = @base_name.pluralize
	end
	
	def manifest
		record do |m| 
			m.migration_template "#{@model_name}_migration.rb.erb",
														File.join("db", "migrate"),
														:migration_file_name => "create_#{@plural_name}"
			m.migration_template "#{@model_name}_option_migration.rb.erb",
														File.join("db", "migrate"),
														:migration_file_name => "create_#{@base_name}_options"
			m.template "poll.rb.erb", File.join("app/models/", "#{@model_name}.rb")
			m.template "poll_option.rb.erb", File.join("app/models/", "#{@model_name}_option.rb")
			#add the view in app/views/shared
			m.directory "app/views/shared"
			m.template "_poll.html.erb", File.join("app/views/shared", "_poll.html.erb")
			m.template "_result.html.erb", File.join("app/views/shared", "_result.html.erb")
			#creates the controller
			m.template "poll_controller.rb.erb", File.join("app/controllers", "#{@base_name}_controller.rb")
			m.template "poll_helper.rb", File.join("app/helpers", "#{@base_name}_helper.rb")
			#add the progressbar.css to the public
			m.template "css/progressbar.css", File.join("public/stylesheets", "progressbar.css")
		end
	end
	
end
