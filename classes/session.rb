class Session 

attr_reader :start
attr_accessor :end, :total_time, :status

    def initialize
        @status = true
        @start = Time.now 
        @end = nil 
        @total_time = 0
        @message = "Session in Progress"
    end 


    def session_total_time 
        @total_time = @end - @start 
    end 

    def end_session 
        @end = Time.now 
        @status = false
        @message = "Welcome to Time Clock"
        session_total_time 
    end 

end 