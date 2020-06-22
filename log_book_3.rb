require 'time'

#05/07/2020:

#File.new("in_and_out", "w")
#File.new("time_in", "w")


#class Time_Clock
#killed the class to see what that would look like.
 #set class for time clock

  #@in_and_out and @time might be able to be subbed in for file addresses...
  #this could make the code more general. Wanted to limit contigencies so I just
  #manually put the file names in... this could be refactored though.

#@in_and_out and @time
#@time_log is for my wholesale importing, editing and then writing procedure.
#@total time is going to keep track of the total about studied.

  def clock_in(time_in, in_and_out)
    #write the new log in time to the "in and out file"
    #now writing it so the new additions go to the top of the file using "unshift"
    time = Time.now
    time_in = File.write(time_in, time )

    new_log = "IN: #{time.strftime("%m/%d")} @ #{time.strftime("%H:%M")}"
    log_read = File.open(in_and_out, "r")
    log_line_array = create_file_array(log_read)
    #using #unshift to enter new log at the log of the page
    updated_log_book = log_line_array.unshift(new_log)
    log_write = File.open(in_and_out, "w")
    log_write.puts updated_log_book
    log_write.close
    #write clock in time to temporary "time-in file for retrievel later.
      puts "#{time.strftime("%m/%d/%Y")}: IN #{time.strftime("%H:%M")}"
  end


  def clock_out(in_and_out, time_in, total_time)
    time = Time.new
    total_time_read = File.open(total_time, "r")
    total_time_for_calc =  total_time_read.gets.to_f
    total_time_read.close

    new_log = "OUT: #{time.strftime("%m/%d")} @ #{time.strftime("%H:%M")}: #{total_time_for_calc}"
    #recall the full log and set it up to add new clock out to top of file.
    log_line_array = create_file_array(in_and_out)
    updated_log_book = log_line_array.unshift(new_log)
    log_write = File.open(in_and_out, "w")
    log_write.puts updated_log_book
    #do File.write FILE objects need to be closed?
    time_in_read = File.open(time_in,"r")
    time_in = time_in_read.gets
    time_in_for_calc = Time.parse(time_in)
      time_in_read.close
    session_elapsed_time = (time.to_f.round(2) - time_in_for_calc.to_f.round(2))/3600

    new_total_time = session_elapsed_time + total_time_for_calc
    total_time_write = File.open(total_time, "w")
    total_time_write.puts new_total_time
    total_time_write.close

      puts "IN: " + time_in_for_calc.strftime("%H:%M")
      puts "OUT: " + time.strftime("%H:%M")
      puts "#{session_elapsed_time.round(2)} hours logged."
      puts "#{new_total_time.round(2)} total. Run, Code, Run!!!"
  end

  def log(log_book)
    #put a date into the log when you sign in...
    date = Time.new.strftime("%m/%d")
    time = Time.new.strftime("%H:%M")

    log_book = File.open(log_book, "r")
    text = File.read(log_book)
      log_book.close
    note = gets.to_s
    new_text = date + " " + time + ": " + note + " " + text
    #new_text.unshift("#{date} @ #{tceaime}")
    #vs. above concatenation
    updated_log_book = File.open(log_book, "w")
      updated_log_book.puts new_text
      updated_log_book.close
      puts "#{date} @ #{time}: it's time to..."
  end


  def print_selection(file_array, count)
      print file_array[count]
  end

  def stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
      count += 1
      selection = gets.to_i

    if selection == 0
      if count >= file_array.length
        count = 0
      end
      print_selection(file_array, count) #pass
      stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)

    elsif selection == 4  #this is how we delete things...
      #what am I telling it to delete actually... how do we know
      #where we are in the line
        deleted_item = file_array.delete_at(count - 1)
        puts "#{deleted_item} has been removed."
        #could remove it to a file collecting older entries.
        stack_file = File.open(stack, "w")
          stack_file.puts file_array
          stack_file.close
          stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
    elsif selection == 6
        file_array = add_to_stack(stack, count)
          stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
    elsif selection == 7  #list
        count = 0
        until count >= file_array.length
          file_array.each do |item|
            puts "#{count + 1}. #{item}"
            count += 1
          end
            puts "Please select a number:"
          choice = gets.to_i
          count = choice - 1
          print_selection(file_array, count)
          stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
        end
      elsif selection == 8
        main_menu(stack, in_and_out, time_in, total_time, log_book, idea_file)
      else
        print_selection(file_array, count)
        stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
      end
    end

    def create_file_array(file)
      file = File.open(file,"r")
      current_file = File.readlines(file)
        file.close
      file_array = []
        current_file.each {|line| file_array << line}
        file_array
    end

    def add_to_stack(stack, count)
      addition = gets.chomp.to_s
      file_array = create_file_array(stack)
      file_array << addition
      stack_file = File.open(stack, "w")
      stack_file.puts file_array
      stack_file.close
      print "#{addition} has been added."
      file_array
    end


    def stack(stack, in_and_out, time_in, total_time, log_book, idea_file)
      menu = "PASS (0) | RELEASE (4) | ADD (6) | LIST (7) | MAIN (8)"
      count = 0
      #add to stack, subtract from stack, notate stack items
      #staack item could be an object, a container for knowing a few things about itself.
      file_array = create_file_array(stack)
      puts file_array[0]
      puts menu
      stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
    end

    def ideas(idea_file)
      #not sure what is going on here, but had to leave this for now.
      date = Time.new.strftime("%m/%d")
      time = Time.new.strftime("%H:%M")

      idea_log = File.open(idea_file, "r")
      current_ideas = File.read(idea_log)
        idea_log.close
      new_idea = gets.to_s
      updated_ideas = date + " " + time + ": " + new_idea + " " + current_ideas
  #new_text.unshift("#{date} @ #{time}")
  #vs. above concatenation
      updated_file = File.open(idea_file, "w")
        updated_file.puts updated_ideas
        updated_file.close
        puts "#{date} @ #{time} idea update complete"
        exit
    end


    def main_menu(stack, in_and_out, time_in, total_time, log_book, idea_file)

        puts "     === === ===== = ======= ==== === ===== === == ==== = == =="
        puts "  ==== ==== ===== === ==== LOG BOOK 3 == = == == === =========== ====="
        puts "===== == ======= === ==== == ===== ========= ===== ===== ======= ="
        puts "          IN (3) | OUT (5) | LOG (8) | STACK (9) | IDEAS (0)"
        puts "  = == ========= =========== == == ==== ============= ===== === = ===="
        puts "======== =============== ======== = = ====== ===== == ======== ========== =="

      count = 0

      action = gets.to_i

        case action
        when 3
          clock_in(time_in, in_and_out)
        when 5
          clock_out(in_and_out, time_in, total_time)
        when 8
          log(log_book)
        when 9
          stack(stack, in_and_out, time_in, total_time, log_book, idea_file)
        when 0
          ideas(idea_file)
        when 2
          puts "Welcome to your vocation."
        when 4
          puts "We having fun yet?"
        else
          puts "What now?"
        end

      end

  main_menu(stack = "stack.txt", in_and_out = "in_and_out", time_in = "time_in", total_time = "total_time", log_book = "log_book", idea_file = "ideas.txt")

#action.to_i == 8 ? my_time_clock.clock_in : my_time_clock.clock_out

__END__

  @date_format = "%m/%d/%Y %H:%M"  - this can then be fed to a Time.strftime method

  %X = time only;

  require 'time' allows for Time.parse
  file = File.open("total_time", "r")


  time_in = Time.parse(file.read)

  time = Time.new

  elapsed_time = time - time_in
  p elapsed_time/60

  #CLOCK_TIME = self.strftime("%H:%M") + " on " + self.strftime("%M %D")
