
#this silences the "warning: class variable access from toplevel"
$VERBOSE = nil


@@read_file = File.open("exercise_log", "r")
@@write_file = File.open("exercise_log", "w")
@@pushups = nil
@@situps = nil
@@log = ["Pushups", nil, "Situps", nil]

def prompt
  puts "How many, tough guy?"
end

def read_file
  text = File.readlines(@@read_file)
  @@read_file.close
  text_array= []
  text.each {|line| text_array << line}
  return text_array
end

def self.write_file
  text = File.readlines(@@write_file)
end

def add_pushups
  prompt
  num = gets.to_i
#change this to gets when I have the kinks worked out
  update = read_file[1].to_i
  @@log[1] = update + num
  @@write_file.puts @@log
  #!!!!!!!! why can't I get these to accumulate... this is stupid... let's
  #look back at the code for log_book_3 and see if it is transferrable.
  #it should be!!!
end

def add_situps
  num = gets.to_i
#change this to gets when I have the kinks worked out
  exercise_array = read_file
  exercise_array[3] =+ num
  @@write_file.puts exercise_array
end

puts "== ==== === ===== == ===== ==== ="
puts "           EXERCISE"
puts "   PUSHUPS (1) | SITUPS (2)"
puts "== ===== ==== ==== ====== ==== =="


action = gets.to_i

if action == 1
  add_pushups
elsif action == 2
  add_situps
else
  puts "This shit ain't working"
end
