class Timer

  attr_accessor :active, :remaining

  def initialize(window)
    @remaining = 60
    @last_start = Gosu.milliseconds
    @remaining_at_last_start = 60
    @active = false
    @window = window
    @font = Gosu::Font.new(window.x_size / 3)
    @key = Gosu::KbSpace
  end

  def update
    if @active
      ms_elapsed = Gosu.milliseconds - @last_start
      s_elapsed = ms_elapsed.to_f / 1000.0
      @remaining = @remaining_at_last_start - s_elapsed
    end
    check_keys
  end

  def check_keys
    if @window.button_down?(@key)
      @active ? stop : start unless @key_down
      @key_down = true
    else
      @key_down = false
    end
  end

  def draw
    @font.draw_rel(
      @remaining.to_i, @window.x_size / 2, (@window.y_size / 2),
      0, 0.5, 0.5
    )
  end

  def start
    unless @active
      @active = true
      @last_start = Gosu.milliseconds
      @remaining_at_last_start = @remaining
    end
  end

  def stop
    @active = false
  end

end