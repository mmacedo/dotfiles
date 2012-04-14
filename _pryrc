# coding:utf-8 vim:ft=ruby

require 'map_by_method'
require 'awesome_print'
require 'hirb'

Hirb.enable

Pry.config.editor = "mvim --no-fork"

Pry.config.prompt = [
  proc { |obj, nest_level, pry|
    version = RUBY_VERSION
    version += "-#{Rails::VERSION::STRING}" if defined? Rails
    tree = pry.binding_stack.map {|b| Pry.view_clip b.eval("self") }.join "/"
    tree = if tree == 'main' then '' else " (#{tree}):#{nest_level}" end
    "#{version}#{tree} » "
  },
  proc { |obj, nest_level, pry|
    "\e[31m?> \e[m"
  }
]

Pry.config.print = proc do |output, value|
  value = value.to_a if defined?(ActiveRecord) && value.is_a?(ActiveRecord::Relation)
  Hirb::View.view_or_page_output(value) || Pry::Helpers::BaseHelpers.stagger_output(value.ai)
end

Pry.config.exception_handler = proc do |output, exception, pry|
  if exception.instance_of? Interrupt
    output.puts ""
    output.puts "\e[31m^C\e[m"
  else
    output.puts "\e[31m#{exception.class}: #{exception.message}"
    output.puts "from #{exception.backtrace.first}"
    output.puts "Run `enter-exception` to debug.\e[m"
  end
end

Pry.hooks.add_hook :before_session, :rails do |output, target, pry|
  unless defined?(Rails) && Rails.env
    begin
      require './config/environment' if File.exists? './config/environment.rb'
    rescue
      return
    end
  end


  # show ActiveRecord SQL queries in the console
  if defined? ActiveRecord
    ActiveRecord::Base.logger = Logger.new STDOUT
  end

  if defined?(Rails) && Rails.env
    # output all other log info such as deprecation warnings to the console
    if Rails.respond_to? :logger=
      Rails.logger = Logger.new STDOUT
    end

    # load Rails console commands
    if Rails::VERSION::MAJOR >= 3
      require 'rails/console/app'
      require 'rails/console/helpers'
      if Rails.const_defined? :ConsoleMethods
        extend Rails::ConsoleMethods
      end
    else
      require 'console_app'
      require 'console_with_helpers'
    end
  end
end
