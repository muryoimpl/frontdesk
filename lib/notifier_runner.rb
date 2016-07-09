require 'yaml'

class FrontDesk::NotifierRunner
  class << self
    def run(value)
      FrontDesk::Notifier.subclasses.each do |notifier|
        case value
        when PiPiper::Pin::GPIO_HIGH
          notifier.instance.enter
        when PiPiper::Pin::GPIO_LOW
          notifier.instance.leave
        end
      end
    end

    def notifier_file_paths
      @notifier_file_paths = [Pathname('./lib/notifiers/*.rb')]
    end

    def require_notifiers
      Dir[*notifier_file_paths].each do |f|
        next unless use?(notifier)

        require f
      end
    end

    private

    def use?(notifier)
      using_notifiers.include?(notifier.to_s)
    end

    def using_notifiers
      Settings.notifiers
    end
  end
end
