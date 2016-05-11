class Servo

  attr_accessor :pos, :state, :steps, :base

  def initialize(base, min, max, steps)
    @base = base
    @min = min
    @max = max
    @pos = base
    @steps = steps
    @step = (@max - @min) / (@steps - 1.0)
    @state = get_state base
  end

  def get_state(pos)
    ((pos - @min) / @step).round
  end

  def update(action)
    old_state = @state
    if action % 2 > 0 and @state < @steps - 1
      @pos += @step
      @state += 1
    elsif action % 2 == 0 and @state > 0
      @pos -= @step
      @state -= 1
    end
    old_state == @state ? false : true
  end
end