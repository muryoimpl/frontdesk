class FrontDesk::LEDNotifier < FrontDesk::Notifier
  def initialize
    @pin ||= PiPiper::Pin.new(pin: Settings.pins.led, direction: :out)
  end

  def enter
    puts 'enter led'
    @pin.on
  end

  def leave
    puts 'leave led'
    @pin.off
  end
end
