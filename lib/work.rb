class FrontDesk::Work
  class << self
    def start
      PiPiper.watch pin: Settings.pins.infrared_sensor do
        read

        FrontDesk::NotifierRunner.run(value) if changed?
      end

      PiPiper.wait

      at_exit {
        [Settings.pins.infrared_sensor].each do |pin|
          File.open('/sys/class/gpio/unexport', 'w') {|f| f.write(pin.to_s) }
        end
      }
    end
  end
end
