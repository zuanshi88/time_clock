require "./classes/time_clock.rb"
require "./modules/formatting_module.rb"

include Formatting






app = Time_Clock.new

system('clear')

drop_center

app.main_menu.each{|line| center_text(line)}

app.options