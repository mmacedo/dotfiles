# coding:utf-8 vim:ft=ruby

gems = %w{map_by_method awesome_print hirb}

Pry.config.print = proc do |output, value|
  value = value.to_a if defined?(ActiveRecord) && value.is_a?(ActiveRecord::Relation)
  value = value.to_a if defined?(Mongoid) && value.is_a?(Mongoid::Criteria)
  Hirb::View.view_or_page_output(value) || Pry::Helpers::BaseHelpers.stagger_output(value.ai)
end

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

Pry.hooks.add_hook :before_session, :gems  do

  require 'rubygems'
  ENV['BUNDLE_GEMFILE'] ||= File.expand_path 'Gemfile'
  gemfile = ENV['BUNDLE_GEMFILE']
  lockfile = "#{ENV['BUNDLE_GEMFILE']}.lock"

  if File.exists?(gemfile) && File.exists?(lockfile)
    lines = File.open(lockfile).to_a
    # require what is not in the Gemfile before loading Bundler
    gems.delete_if{|g| lines.all?{|line| line !~ /^\s*#{g}\s/ } && ( require g || true ) }
    require 'bundler/setup'
  end

  gems.each{|g| require g }.clear
  Hirb.enable
end

Pry.hooks.add_hook :before_session, :rails do

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
