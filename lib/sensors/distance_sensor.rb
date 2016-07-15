class FrontDesk::DistanceSensor
  class << self
    def setup
      @@trig_pin ||= PiPiper::Pin.new(pin: Settings.pins.distance_sensor.trig, direction: :out)
      @@echo_pin ||= PiPiper::Pin.new(pin: Settings.pins.distance_sensor.echo, trigger: :falling)
    end

    def trigger!
      @@trig_pin.on
      sleep 0.0001
      @@trig_pin.off
    end

    def wait_for_change
      @@echo_pin.wait_for_change
    end
  end
end
