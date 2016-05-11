require 'rubygems'
require 'bundler'
Bundler.setup(:default)
Bundler.require(:default)
require 'json'
require_relative 'agent'
require_relative 'servo'
require_relative 'utilities'

servo_1 = Servo.new 84, 80, 120, 10
servo_2 = Servo.new 30, 30, 90, 10
agent = Agent.new servo_1, servo_2, 4, 0.1, 0.2, 0.75
distance = 0
distance_old = 0

#serial = setup_bluetooth
#setup_servos serial, servo_1, servo_2

loop do
  distance = rand 10 #read_data serial
  state = agent.state servo_1, servo_2
  action = agent.find_action state
  updated = case action
              when (0..1) then
                servo_1.update action
              when (2..3) then
                servo_2.update action
            end
  puts "#{state}, #{action}       #{servo_1.pos.round}, #{servo_2.pos.round}        #{servo_1.state}, #{servo_2.state}      #{updated}"
  agent.update state, action, distance - distance_old, agent.state(servo_1, servo_2) if updated
  distance_old = distance
#send_data serial, servo_1, servo_2
  sleep 0.2
end

