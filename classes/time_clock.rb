require 'time'
require_relative 'session.rb'
require './modules/formatting_module.rb'

include Formatting

  class Time_Clock 

      attr_reader :database_file, :database, :session_info, :clock_in
      attr_accessor :message

    def initialize
      @database_file = './database/session_database.txt'
      @message = "Welcome to your time clock"
      @database = marshal_open
    end

    def set_message(mess) 
      @message = mess
    end 

    def marshal_save
        File.open(@database_file, "wb"){|f| f.write(Marshal.dump(@database))}
    end

    def marshal_open 
        File.open(@database_file, "rb"){|from_file| Marshal.load(from_file)}
    end 
   

    def main_menu
                              
         ["== = == ==== === =   === === ===== = ======= ==== === ===== === == ==== = == == ",
          " == =  ===  ==== ==== ===== === #{@message} == = == == === =========== ===== ",
         " == === == = ===  ==  ===== == ======= === ==== == ===== ========= ===== ===== ======= =",
        " IN (3) | OUT (4) | WRITE-IN (6) | WRITE-OUT (7) | LOG (8) | STACK (9) | IDEAS (0) | EXIT (1) ",
          " == === == = == ========= =========== == == ==== ============= ===== === = ==== ",
         " = == = == =  ======== =============== ======== = = ====== ===== == ======== ========== == ",
           "  === ===== == = = = ===== === ===== === == == = == ===== == === === === =="]
    end 

    
    def options 
      action = gets.to_i

        case action
        when 3
           clock_in
           clock_in_out_display
        when 4
           clock_out
           clock_in_out_display
        when 5
          coding_session = Activity.new("CODING")
          coding_session.clock_out
        when 6
          writing_session = Activity.new("WRITING")
          writing_session.clock_in
        when 7
          writing_session = Activity.new("WRITING")
          writing_session.clock_out
        when 8
          log(log_book)
        when 9
          stack()
        when 0
          ideas()
        when 1
          exit
        else
          puts "WHat the?"
        end

      end

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
            if @database.empty? || @database[-1].status == false
              @database << Session.new
              self.set_message("Session Initiated")
              self.marshal_save
              @database = marshal_open
            else 
              self.set_message("Session in Progress")
              self.marshal_save
              @database = marshal_open
            end 
        end

        def clock_out 
            if @database.empty? 
              return  self.set_message("Sorry, no session in progress")
            end 
            if @database[-1].status == true 
              curr_session = @database.pop
               curr_session.end_session
               refresh_database(curr_session)
              self.set_message("Session Terminated: length: #{curr_session.total_time}; total: #{totalize_time}")
          
            else 
                self.set_message("Sorry, no session in progress")
            end 
        end 

        def totalize_time 
          @database.map{|session| session.total_time}.reduce(:+).round(2)
        end


        def clock_in_out_display
            system('clear')
            drop_center
            self.main_menu.each{|line| center_text(line)}
            self.options
        end 

        def refresh_database(curr_session) 
          @database << curr_session
          self.marshal_save
          @database = marshal_open
        end 
      end

         
          # puts ""
          # puts "          #{time.strftime("%m/%d/%Y")}:  #{@type} IN  (#{time.strftime("%H:%M")})"

      