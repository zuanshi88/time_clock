require 'time'

#File.new("in_and_out", "w")
#File.new("time_in", "w")


#class Time_Clock
#killed the class to see what that would look like.
 #set class for time clock

  #@in_and_out and @time_out might be able to be subbed in for file addresses...
  #this could make the code more general. Wanted to limit contigencies so I just
  #manually put the file names in... this could be refactored though.

#@in_and_out and @time_out
#@time_log is for my wholesale importing, editing and then writing procedure.
#@total time is going to keep track of the total about studied.

  def day_number
    Time.new.


  def clock_in(filename)
    #write the new log in time to the "in and out file"
    #now writing it so the new additions go to the top of the file using "unshift"
    time = Time.now
    new_log = "IN: #{time.strftime("%m/%d")} @ #{time.strftime("%H:%M")}"
#   filename = in_and_out
    file = File.open(filename)
    log_read = IO.readlines(file)
    file.close
    log_line_array = []
    log_read.each {|line| log_line_array << line}
    new_log_line_array = log_line_array.unshift(new_log)
    log_write = File.open(file_name, "w")
    log_write.puts new_log_line_array
    log_write.close
    #write clock in time to temporary "time-in file for retrievel later.
    time_in = File.open("time_in", "w")
    time_in.puts time
    time_in.close
    puts "You just clocked IN at #{time.strftime("%H:%M")} on #{time.strftime("%m/%d/%Y")}"
  end


  def clock_out(filename)
    time_out = Time.new
    new_log = "OUT: #{time_out.strftime("%m/%d")} @ #{time_out.strftime("%H:%M")}"
    #recall the full log and set it up to add new clock out to top of file.
    log_read = File.open(filename, "r")
    log_lines = IO.readlines(log_read)
      log_read.close
    log_line_array = []
      log_lines.each {|line| log_line_array << line}
    new_log_line_array = log_line_array.unshift(new_log)
    log_write = File.open("in_and_out", "w")
      log_write.puts new_log_line_array
      log_write.close

    file_read = File.open("time_in","r")
    time_in = file_read.gets
    time_in_calc = Time.parse(file_read)
      file_read.close
    elapsed_time = (time_out.to_i- time_in_calc.to_i)/60

    file_read = File.open("total_time", "r")
    total_time =  file.gets.to_i
      file_read.close
    new_total_time = elapsed_time + total_time
    file_write = File.open("total_time", "w")
      file_write.puts new_total_time
      file_write.close
    new_time = Time.parse(time_in).strftime("%H:%M")
      puts "Today IN: " + new_time
      puts "Today OUT: " + time_out.strftime("%H:%M")
      puts "You've just logged in #{elapsed_time} minutes today."
      puts "#{new_total_time} minutes studied. Keep it up!!"
  end

  def log
    #put a date into the log when you sign in...
    date = Time.new.strftime("%m/%d")
    time = Time.new.strftime("%H:%M")

    log_book = File.open("log_book", "r")
    text = File.read(log_book)
      log_book.close
    note = gets.to_s
    new_text = time + ": " + note + " " + text
    #new_text.unshift("#{date} @ #{time}")
    updated_log_book = File.open("log_book", "w")
      updated_log_book.puts new_text
      updated_log_book.close
      puts "Your note for #{date} @ #{time} has been recorded"
  end

  def stack
    stack = [
      "Boris", "JavaScript Intro Lecture", "Eloquent JavaScript", "das_stack", "name_change",
      "excel_with_ruby","address_book", "File(docx)", "Family Budget",
      "Life Insurance", "Investment organization", "塔罗","Push/sit",
      "Diamond Essentials!!!", "Resume", "瑜伽"]

      puts "next on the docket is:"
      puts
      puts stack[0]
      gets
      puts "And the rest of the lot of course:"

      puts stack[1..-1]
  end


puts "            ++++++ +++++++++++++ ++++++++++"
    puts "      ++++++++ +++++++++++ ++++++++++++++"
      puts "  +++++ +++ ++ JOURNAL 3000  ++++ ++++"
  puts "    ++++ ++++++++ ++++++++ +++++++++ ++++++++"
  puts "   +++++++ +++++++ +++++++++++ ++++++++++++++++"
  puts  "+++  IN (1) | OUT (0) | STACK (5) | LOG(*) +++++"
  puts " +++++++++++++++++++++++++++ ++++++++++++++++++++"
  puts "   ++++++++ ++++++++++++++++++++ +++++++++++++++"
  puts "     +++++++++++ +++++++++++++++++ ++++++++++"

action = gets.to_i

  if action == 1
    clock_in
  elsif action == 8
    clock_out
  elsif action == 5
    stack
  else
    log
  end

#action.to_i == 8 ? my_time_clock.clock_in : my_time_clock.clock_out

__END__

  @date_format = "%m/%d/%Y %H:%M"  - this can then be fed to a Time.strftime method

  %X = time only;

  require 'time' allows for Time.parse
  file = File.open("total_time", "r")


  time_in = Time.parse(file.read)

  time_out = Time.new

  elapsed_time = time_out - time_in
  p elapsed_time/60

  #CLOCK_TIME = self.strftime("%H:%M") + " on " + self.strftime("%M %D")
