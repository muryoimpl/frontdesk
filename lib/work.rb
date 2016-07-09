class FrontDesk::Work
  class << self
    def start
      NotifierRunner.require_notifiers

      setup_distance_sensers

      PiPiper.watch pin: Settings.pins.infrared_sensor do
        read

        FrontDesk::NotifierRunner.run(value) if changed?
      end

      PiPiper.wait

      at_exit {
        [
          Settings.pins.infrared_sensor,
          Settings.pins.distance_sensor.echo,
          Settings.pins.distance_sensor.trig
        ].each do |pin|
          File.open('/sys/class/gpio/unexport', 'w') {|f| f.write(pin.to_s) }
        end
      }
    end

    private

    def setup_distance_sensers
      distance_trig_pin
      distance_echo_pin
    end

    def distance_trig_pin
      @distance_trig_pin ||= PiPiper::Pin.new(Settings.pins.distance_sensor.trig, direction: :out)
    end

    def distance_echo_pin
      @distance_echo_pin ||= PiPiper::Pin.new(Settings.pins.distance_sensor.echo, trigger: :rising)
    end
  end
end
