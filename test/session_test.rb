require './classes/session.rb'

require 'test/unit'

class SessionTest < Test::Unit::TestCase 


    def setup 
        @session = Session.new
    end 

    def test_session_has_status 
        assert_equal(true, @session.status)
    end 

    def test_session_can_change_status
        @session.status = false 
        assert_equal(false, @session.status)
    end 


    def test_session_has_info
        assert_equal(Time, @session.start.class)
    end 

    def test_session_has_nil_end 
        assert_equal(nil, @end)
    end 

    def test_session_has_zero_total_time 
        assert_equal(0, @session.total_time)
    end 

    #this test passed, but costs 5 seconds so we'll quiet it for now

    # def test_session_can_calculate_total_time 
    #     @session.start 
    #     sleep(5)
    #     @session.end_session
    #     assert_operator(5, :<=, @session.total_time)
    # end 



end 