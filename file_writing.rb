require 'time'

list = File.open("list_list", "r")


time = Time.new

#list.puts [time, 57, "Martha", "pizza", ["coins", "a lighter", "a phone number"]]

list_contents = []
data = IO.readlines(list)
data.each {|line| list_contents << line}
puts list_contents


number = list.read
