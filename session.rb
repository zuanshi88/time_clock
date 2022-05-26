require 'time'


  class Session

      attr_reader :database_file, :database, :info, :clock_in
      attr_accessor :status 

    def initialize
      @status = false 
      @database_file = './database/session_database.txt'
      @info = []
    end

    def marshal_save
        File.open(@database_file, "wb"){|f| f.write(Marshal.dump(@info))}
    end

    def marshal_open 
        File.open(@database_file, "rb"){|from_file| Marshal.load(from_file)}
    end 
   

    def main_menu

        "   == = == ==== === =   === === ===== = ======= ==== === ===== === == ==== = == == \n
          == =  ===  ==== ==== ===== === ==== LOG BOOK 3 == = == == === =========== ===== \n
         == === == = ===  ==  ===== == ======= === ==== == ===== ========= ===== ===== ======= =\n
        IN (3) | OUT (5) | WRITE-IN (6) | WRITE-OUT (7) | LOG (8) | STACK (9) | IDEAS (0) | EXIT (1) \n
          == === == = == ========= =========== == == ==== ============= ===== === = ==== \n
         = == = == =  ======== =============== ======== = = ====== ===== == ======== ========== == \n
            === ===== == = = = ===== === ===== === == == = == ===== == === === === =="
    end 
    

      # action = gets.to_i

      #   case action
      #   when 3
      #      coding_session = Activity.new("CODING")
      #      coding_session.clock_in
      #   when 4
      #     add_pushups
      #   when 5
      #     coding_session = Activity.new("CODING")
      #     coding_session.clock_out
      #   when 6
      #     writing_session = Activity.new("WRITING")
      #     writing_session.clock_in
      #   when 7
      #     writing_session = Activity.new("WRITING")
      #     writing_session.clock_out
      #   when 8
      #     log(log_book)
      #   when 9
      #     stack()
      #   when 0
      #     ideas()
      #   when 1
      #     exit
      #   else
      #     puts "WHat the?"
      #   end

      # end

#       def check_session_status
#         read_file = File.open(@status_file, "r")
#         session_status = read_file.gets
#         if session_status =~ /true/
#           return true
#         else
#           #this will change status on log in
#           return false
#         end
#       end

#       def record_session_status(status_file)
#         session_file = File.open(status_file, "w")
#         session_file.puts @session_status
#       end

      def change_status 
        @status = !@status
      end 

      def clock_in
          #write the new log in time to the "in and out file"
          #now writing it so the new additions go to the top of the file using "unshift"
          if @status == true 
            # puts "Current Session in Progress"
            return main_menu
          else
            self.change_status
            time_in = Time.now
            @info << time_in
            self.marshal_save
          end 
        end

          # new_log = "#{@type}IN: #{time.strftime("%m/%d")} @ #{time.strftime("%H:%M")}"
          # log_read = File.open(@in_and_out, "r")
          # log_line_array = create_file_array(log_read)
          # #using #unshift to enter new log at the log of the page
          # updated_log_book = log_line_array.unshift(new_log)
          # log_write = File.open(@in_and_out, "w")
          # log_write.puts updated_log_book
          # log_write.close
          # #write clock in time to temporary "time-in file for retrievel later.
          # puts ""
          # puts "          #{time.strftime("%m/%d/%Y")}:  #{@type} IN  (#{time.strftime("%H:%M")})"
        end


#         def clock_out

#           if !check_session_status
#             puts "No CURRENT session"
#             return main_menu
#           else
#             @session_status = false
#             record_session_status(@status_file)
#           end

#           time = Time.new
#           total_time_read = File.open(@total_time, "r")
#           total_time_for_calc =  total_time_read.gets.to_f
#           total_time_read.close

#           #do File.write FILE objects need to be closed?
#           time_in_read = File.open(@time_in,"r")
#           time_in = time_in_read.gets
#           time_in_for_calc = Time.parse(time_in)
#           time_in_read.close
#           session_elapsed_time = (time.to_f.round(2) - time_in_for_calc.to_f.round(2))/3600
#           new_total_time = session_elapsed_time + total_time_for_calc

#           new_log = "#{@type} OUT: #{time.strftime("%m/%d")} @ #{time.strftime("%H:%M")}: #{new_total_time}"
#           #recall the full log and set it up to add new clock out to top of file.
#           log_line_array = create_file_array(@in_and_out)
#           updated_log_book = log_line_array.unshift(new_log)
#           log_write = File.open(@in_and_out, "w")
#           log_write.puts updated_log_book

#           total_time_write = File.open(@total_time, "w")
#           total_time_write.puts new_total_time
#           total_time_write.close
#           puts ""
#           puts "                      -=-=-=-=-=-=-=-=-"
#           puts "                    session #{@type} complete"
#           puts "                    -=-=-=-=-=-=-=-=-=-=-"
#           puts "  "
#           puts "                         " + time.strftime("%m/%d/%Y")
#           puts "  "
#           puts "                          #{session_elapsed_time.round(2)} hrs."
#           puts "  "
#           puts "                  IN (" + time_in_for_calc.strftime("%H:%M") + ") | OUT (" + time.strftime("%H:%M") + ")"
#           puts "                   "
#           puts "                         [ #{new_total_time.round(2)} ]"
#           puts "                "
#           puts "                          =-=-=-="
#           puts "                            =-=-"
#           puts "                             =-"


#           puts ""
#         end

#       def log(log_book)
#         #put a date into the log when you sign in...
#         date = Time.new.strftime("%m/%d")
#         time = Time.new.strftime("%H:%M")

#         log_book = File.open(@log_book, "r")
#         text = File.read(@log_book)
#           log_book.close
#         note = gets.to_s
#         new_text = date + " " + time + ": " + note + " " + text
#         #new_text.unshift("#{date} @ #{tceaime}")
#         #vs. above concatenation
#         updated_log_book = File.open(@log_book, "w")
#           updated_log_book.puts new_text
#           updated_log_book.close
#           puts "#{date} @ #{time}: it's time to..."
#       end


#       def print_selection(file_array, count)
#           print file_array[count]
#       end

#       def stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
#           count += 1
#           selection = gets.to_i

#         if selection == 0
#           if count >= file_array.length
#             count = 0
#           end
#           print_selection(file_array, count) #pass
#           stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)

#         elsif selection == 4  #this is how we delete things...
#           #what am I telling it to delete actually... how do we know
#           #where we are in the line
#             deleted_item = file_array.delete_at(count - 1)
#             puts "#{deleted_item} has been removed."
#             #could remove it to a file collecting older entries.
#             stack_file = File.open(stack, "w")
#               stack_file.puts file_array
#               stack_file.close
#               stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
#         elsif selection == 6
#             file_array = add_to_stack(stack, count)
#               stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
#         elsif selection == 7  #list
#             count = 0
#             until count >= file_array.length
#               file_array.each do |item|
#                 puts "#{count + 1}. #{item}"
#                 count += 1
#               end
#                 puts "Please select a number:"
#               choice = gets.to_i
#               count = choice - 1
#               print_selection(file_array, count)
#               stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
#             end
#           elsif selection == 8
#             main_menu(stack, in_and_out, time_in, total_time, log_book, idea_file)
#           else
#             print_selection(file_array, count)
#             stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
#           end
#         end

#         def create_file_array(file)
#           file = File.open(file,"r")
#           current_file = File.readlines(file)
#             file.close
#           file_array = []
#             current_file.each {|line| file_array << line}
#             file_array
#         end

#         def add_to_stack(stack, count)
#           addition = gets.chomp.to_s
#           file_array = create_file_array(stack)
#           file_array << addition
#           stack_file = File.open(stack, "w")
#           stack_file.puts file_array
#           stack_file.close
#           print "#{addition} has been added."
#           file_array
#         end


#         def stack(stack, in_and_out, time_in, total_time, log_book, idea_file)
#           menu = "PASS (0) | RELEASE (4) | ADD (6) | LIST (7) | MAIN (8)"
#           count = 0
#           #add to stack, subtract from stack, notate stack items
#           #staack item could be an object, a container for knowing a few things about itself.
#           file_array = create_file_array(stack)
#           puts file_array[0]
#           puts menu
#           stack_menu_selection(file_array, count, total_time, stack, in_and_out, time_in, log_book, idea_file)
#         end

#         def ideas(idea_file)
#           #not sure what is going on here, but had to leave this for now.
#           date = Time.new.strftime("%m/%d")
#           time = Time.new.strftime("%H:%M")

#           idea_log = File.open(idea_file, "r")
#           current_ideas = File.read(idea_log)
#             idea_log.close
#           new_idea = gets.to_s
#           updated_ideas = date + " " + time + ": " + new_idea + " " + current_ideas
#       #new_text.unshift("#{date} @ #{time}")
#       #vs. above concatenation
#           updated_file = File.open(idea_file, "w")
#             updated_file.puts updated_ideas
#             updated_file.close
#             puts "#{date} @ #{time} idea update complete"
#             exit
#         end

#         def add_pushups
#           puts "How many this time?"
#           num = gets.to_i
#           push_up_total = File.open("total_pushups.txt", "r")
#           new_total = push_up_total.gets.to_i + num
#             push_up_total.close
#             File.write("total_pushups.txt", new_total)
#           puts "Roger that- #{num} logged. You new total #{new_total}(since June 5th, 2020)!"
#         end
#     end

#   session = Session.new()
#   session.main_menu

# #action.to_i == 8 ? my_time_clock.clock_in : my_time_clock.clock_out

# __END__

#   @date_format = "%m/%d/%Y %H:%M"  - this can then be fed to a Time.strftime method

#   %X = time only;

#   require 'time' allows for Time.parse
#   file = File.open("total_time", "r")


#   time_in = Time.parse(file.read)

#   time = Time.new

#   elapsed_time = time - time_in
#   p elapsed_time/60

  #CLOCK_TIME = self.strftime("%H:%M") + " on " + self.strftime("%M %D")
