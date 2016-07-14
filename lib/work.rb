module FrontDesk
  class Work
    class << self
      def start
        NotifierRunner.require_notifiers

        setup_distance_sensers

        puts 'ready!'

        PiPiper.watch pin: Settings.pins.infrared_sensor do
          read

          if changed?
            FrontDesk::Work.seat.distance = FrontDesk::Work.calculate_distance
            puts "#{FrontDesk::Work.seat.distance} cm"

            case value
            when PiPiper::Pin::GPIO_HIGH
              NotifierRunner.run(value) if FrontDesk::Work.seat.enter?
            when PiPiper::Pin::GPIO_LOW
              NotifierRunner.run(value) if FrontDesk::Work.seat.leave?
            end
          end
        end

        PiPiper.wait

        at_exit {
          using_pins.each do |pin|
            File.open('/sys/class/gpio/unexport', 'w') {|f| f.write(pin.to_s) }
          end
        }
      end

      def using_pins
        [
          Settings.pins.infrared_sensor,
          Settings.pins.distance_sensor.echo,
          Settings.pins.distance_sensor.trig
        ]
      end

      def setup_distance_sensers
        distance_trig_pin
        distance_echo_pin
      end

      def distance_trig_pin
        @distance_trig_pin ||= PiPiper::Pin.new(pin: Settings.pins.distance_sensor.trig, direction: :out)
      end

      def distance_echo_pin
        @distance_echo_pin ||= PiPiper::Pin.new(pin: Settings.pins.distance_sensor.echo, trigger: :falling)
      end

      def seat
        @seat ||= Seat.new
      end

      # 音速:340(m) * 時間(s) * 100(cmに変換) / 2(往復のため半分に)
      def calculate_distance
        distance_trigger!

        time = count_the_time
        puts time
        340 * time * 100 / 2
      end

      def distance_trigger!
        distance_trig_pin.on
        sleep 0.0001
        distance_trig_pin.off
      end

      def count_the_time
        start = Time.now
        distance_echo_pin.wait_for_change
        Time.now - start # second
      end
    end
  end
end
