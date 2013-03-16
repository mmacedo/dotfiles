begin
  require 'awesome_print'
rescue LoadError => e
  puts "Install '#{e.path}'"
end

def pry?; !!defined? Pry; end
def mri?; !!defined? RUBY_ENGINE and RUBY_ENGINE == "ruby"; end
def jruby?; !!defined? JRuby; end

if pry? and mri?

  def debug
    require 'pry-debugger'
    require 'pry-stack_explorer'
  rescue LoadError
    puts "Install 'pry-debugger' and 'pry-stack_explorer'"
  end

end

if mri?

  def prof(printer_type = :out, profiler_mode = nil, file_name = nil)
    raise "Profile what?" unless block_given?
    require 'ruby-prof' unless defined? RubyProf

    result = nil
    data = RubyProf.profile { result = yield }

    profiler_mode ||= :process_time
    RubyProf.measure_mode = RubyProf.const_get(profiler_mode.upcase)

    case printer_type
    when :out
      RubyProf::GraphPrinter.new(data).print(STDOUT, min_percent: 2)
    when :png
      require 'graphviz' unless defined? GraphViz
      file_name = file_name || "profile.png"
      FileUtils.mkdir_p(File.dirname(file_name))
      io = StringIO.new
      RubyProf::DotPrinter.new(data).print(io, min_percent: 2)
      GraphViz.parse_string(io.string).output(png: file_name)
      puts "Saved to '#{file_name}'"
    when :html
      file_name = file_name || "profile.html"
      FileUtils.mkdir_p(File.dirname(file_name))
      File.open(file_name, 'w') do |io|
        RubyProf::GraphHtmlPrinter.new(data).print(io, min_percent: 2)
      end
      puts "Saved to '#{file_name}'"
    else
      raise "Printer type unknown"
    end

    result
  end

elsif jruby?

  def prof(printer_type = :out, file = nil)
    raise "Profile what?" unless block_given?
    require 'jruby/profiler' unless defined? JRuby::Profiler

    result = nil
    data = JRuby::Profiler.profile { result = yield }

    case printer_type
    when :out
      JRuby::Profiler::GraphProfilePrinter.new(data).printProfile(STDOUT)
    when :html
      file_name = file_name || "profile.html"
      FileUtils.mkdir_p(File.dirname(file_name))
      File.open(file, 'w') do |io|
        JRuby::Profiler::HtmlProfilePrinter.new(data).printProfile(io)
      end
      puts "Saved to '#{file}'"
    else
      raise "Printer type unknown"
    end

    result
  end

end

def time
  raise "Time what?" unless block_given?
  require 'benchmark' unless defined? benchmark

  result = nil
  data = Benchmark.measure { result = yield }

  puts('%.2fs' % data.real)

  result
end

def own_methods(o)
  o.methods - o.class.superclass.instance_methods
end
