require './classes/session.rb'
require './classes/time_clock.rb'

require 'test/unit'

class IntegrationTest < Test::Unit::TestCase 

    def setup 
        @session = Session.new
        @time_clock = Time_Clock.new
    end 


    def test_can_persist_data 
        @time_clock.clock_in
        database = @time_clock.marshal_open 
        assert_equal(1, database.size)
    end 

    def test_can_return_menu_when_already_signed_in 
        @time_clock.clock_out
        @time_clock.clock_in 
        assert_equal("Session in Progress", @time_clock.message)
    end 

    def test_saves_each_login 
        @time_clock.clock_in 
        database = @time_clock.marshal_open 
        assert_equal(1, database.size)
    end 

    def test_can_clock_out
        @time_clock.clock_out
        assert_equal("Session Terminated", @time_clock.message[0..17])
    end 

    def test_can_determine_no_session_in_progress 
         @time_clock.clock_in
         @time_clock.clock_out
         assert_equal("Sorry, no session in progress", @time_clock.message)

    end 


end 