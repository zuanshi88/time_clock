require 'time'
require_relative 'session.rb'
require './modules/formatting_module.rb'

include Formatting

  class Time_Clock 

      attr_reader :database_file, :database, :session_info, :clock_in
      attr_accessor :message

    def initialize
      #this call will create .txt file if it does not alread exist 
      #allowing me to push code to github without my current txt file
      system("touch ./database/session_database.txt")
      @database_file = './database/session_database.txt'
      @message = "Welcome to your time clock"
      begin
        @database = marshal_open
      rescue => exception 
        #this code is to keep app from blowing up on first use
        @database = []
        self.marshal_save 
        @database = marshal_open
      end 
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
                              
         ["-------------------------------------------------------------------------",
          "          [#{@message} ]  ",
         "                                                   ",
        "        IN (3) | OUT (4) | EXIT (other)                                   ",
          "---------------------------------------------------------------------------" ]
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
        else
          self.set_message("That's a wrap!")
          clock_in_out_display(true)
         exit
        end

      end

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
              self.set_message("Began: #{curr_session.start.strftime("%H:%M")} / Terminated: #{curr_session.end.strftime("%H:%M")} length: #{curr_session.total_time}; total: #{totalize_time}")
          
            else 
                self.set_message("Sorry, no session in progress")
            end 
        end 

        def totalize_time 
          @database.map{|session| session.total_time}.reduce(:+).round(2)
        end


        def clock_in_out_display(terminate = false)
            system('clear')
            drop_center
            self.main_menu.each{|line| center_text(line)}
            if terminate
              exit
            end 
            self.options
        end 

        def refresh_database(curr_session) 
          @database << curr_session
          self.marshal_save
          @database = marshal_open
        end 
      end