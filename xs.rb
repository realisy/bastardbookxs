require "rubygems"
require "rest-client"
require "open-uri"

# remote_url = "http://en.wikipedia.org/wiki"
# remote_page = "wiki-page.html"

# File.open(remote_page, "w") do |file|
# 	file.write(RestClient.get(remote_url))
# end
#----------------------------------------------------------------
# file = File.open("sample.txt", "r")
# contents = file.read
# puts contents

# contents = file.read
# puts contents
#----------------------------------------------------------------

# url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
# puts open(url).readline

# remote_url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
# remote_page = "hamlet.txt"

# File.open(remote_page, "w") do |file|
# 	file.write(RestClient.get(remote_url))
# end

# file = File.open("hamlet.txt", "r")
# p file.readlines.each_with_index do |line, idx| 
# puts line if idx % 42 == 41 end
# puts sentence

# require 'open-uri'         
# url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
# local_fname = "hamlet.txt"
# File.open(local_fname, "w"){|file| file.write(open(url).read)}

# File.open("hamlet.txt", "r") do |file|
#    file.readlines.each_with_index do |line, idx|
#       puts line if idx % 42 == 41
#    end   
# end

# datafile = File.open("sample.txt", "r")
# lines = datafile.readlines         
# datafile.close

# lines.each{ |line| puts line }         
      
# Or, you can pass a block into File.open. At the end of the block, the file is automatically closed:


# lines = File.open("sample.txt", "r"){ |datafile| 
#    datafile.readlines
# }

# lines.each{|line| puts line}