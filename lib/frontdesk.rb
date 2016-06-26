module FrontDesk
  GPIO_PIN_18 = 18

  class Work
    include ::PiPiper

    class << self
      def start
        PiPiper.watch pin: GPIO_PIN_18 do
          read if changed?

          case value
          when PiPiper::Pin::HIGH
            puts 'enter'
          when PiPiper::Pin::LOW
            puts 'exit'
          end
        end

        PiPer.wait

        at_exit {
          [GPIO_PIN_18].each do |pin|
            File.open('/sys/class/gpio/unexport', 'w') {|f| f.write("#{pin}") }
          end
        }
      end
    end

  end
end
