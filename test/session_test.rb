require './session.rb'

require 'test/unit'

class SessionTest < Test::Unit::TestCase 

    def setup 
        @session = Session.new
    end 

    def test_session_has_status 
        assert_equal(true, @session.status)
    end 

    def test_session_has_database_file 
        assert_equal(String, @session.database_file.class )
    end 

    def test_session_has_database 
        assert_equal(Array, @session.database.class)
    end 


end 