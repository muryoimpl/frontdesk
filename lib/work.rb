module FrontDesk
  class Work
    ENTER = 1
    LEAVE = 0

    class << self
      def start
        NotifierRunner.require_notifiers

        FrontDesk::DistanceSensor.setup

        puts 'ready!'

        PiPiper.watch pin: Settings.pins.infrared_sensor do
          read

          if changed?
            FrontDesk::Work.seat.distance = FrontDesk::Work.calculate_distance
            puts "#{FrontDesk::Work.seat.distance} cm"

            if FrontDesk::Work.seat.enter?
              NotifierRunner.run(ENTER)
            elsif FrontDesk::Work.seat.leave?
              NotifierRunner.run(LEAVE)
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
          Settings.pins.distance_sensor.trig,
          Settings.pins.led
        ]
      end

      def seat
        @seat ||= Seat.new
      end

      # 音速:340(m) * 時間(s) * 100(cmに変換) / 2(往復のため半分に)
      def calculate_distance
        FrontDesk::DistanceSensor.trigger!

        time = count_time
        puts "time: #{time}sec"
        340 * time * 100 / 2
      end

      def count_time
        start = Time.now
        FrontDesk::DistanceSensor.wait_for_change
        Time.now - start # second
      end
    end
  end
end
