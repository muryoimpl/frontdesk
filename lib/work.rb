class FrontDesk::Work
  class << self
    def start
      PiPiper.watch pin: FrontDesk::GPIO_PIN_18 do
        read

        FrontDesk::NotifierRunner.run(value) if changed?
      end

      PiPiper.wait

      at_exit {
        [GPIO_PIN_18].each do |pin|
          File.open('/sys/class/gpio/unexport', 'w') {|f| f.write(pin.to_s) }
        end
      }
    end
  end
end
