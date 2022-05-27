require './classes/session.rb'
require './classes/time_clock.rb'

require 'test/unit'

class TimeclockTest < Test::Unit::TestCase 

    def setup 
        @time_clock = Time_Clock.new
    end 

    def test_time_clock_has_database_file 
        assert_equal(String, @time_clock.database_file.class )
    end 

    def test_marshal_save_and_marshal_open 
        @time_clock.marshal_save 
        database = @time_clock.marshal_open 
        assert_operator(1,:<=, database.size)
    end 

    def test_time_clock_has_main_menu 
        assert_equal(Array, @time_clock.main_menu.class)
    end 

    def test_set_message_can_set_message 
        @time_clock.set_message("HEY!")
        assert_equal("HEY!", @time_clock.message)
    end 

    def test_database_accumulating_sessions
        number = @time_clock.database.size
        assert_equal(1, number)
    end 


end 