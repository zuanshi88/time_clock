#!/bash/bin

echo "Starting test suite!"

ruby ./test/time_clock_test.rb 
ruby ./test/session_test.rb

ruby ./test/integration_test.rb


echo "Test suite complete!"