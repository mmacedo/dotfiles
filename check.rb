#!/usr/bin/env ruby

Dir.chdir File.expand_path(File.dirname(__FILE__))
files = `git ls-files | grep -ve "README\.md" | grep -ve "check\.rb"`.lines.to_a.map{|f| f.chomp }
files.each do |file|
	repofile = File.expand_path(file)
	homefile = File.expand_path("~/.#{file}")

	if ! File.exists? homefile
		puts "#{homefile} does not exist!"
	else
		`diff #{repofile} #{homefile}`
		if $? != 0
			puts "#{homefile} is different!"
		else
			puts "#{homefile} is OK!"
		end
	end
end