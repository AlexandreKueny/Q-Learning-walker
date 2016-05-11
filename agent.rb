require_relative 'servo'

class Agent

  attr_accessor :Q

  def initialize(servo_1, servo_2, nb_actions, alpha, epsilon, gamma)
    @Q = Array.new(servo_1.steps*servo_2.steps){Array.new(nb_actions) {rand}}
    @initial_state = state servo_1, servo_2
    @alpha = alpha
    @epsilon = epsilon
    @gamma = gamma
  end

  def find_best_action(state)
    max = -99999
    best_action = 0
    @Q[state].each_with_index do |r, i|
      if r > max
        max = r
        best_action = i
      end
    end
    best_action
  end

  def state(servo_1, servo_2)
    servo_1.state * servo_2.steps + servo_2.state
  end

  def find_action(state)
    rand < @epsilon ? rand(4) : find_best_action(state)
  end

  def update(state, action, reward, new_state)
    @epsilon *= 0.999
    @Q[state][action] += @alpha * (reward + @gamma * @Q[new_state][find_best_action(new_state)] - @Q[state][action])
  end
end