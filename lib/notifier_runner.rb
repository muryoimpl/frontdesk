class FrontDesk::NotifierRunner
  class << self
    def run(pattern)
      require_notifiers

      FrontDesk::Notifier.subclasses do |notifier|
        next unless use?(notifier)

        case pattern
        when PiPiper::Pin::HIGH
          notifier.enter
        when PiPiper::Pin::LOW
          notifier.leave
        end
      end
    end

    def notifier_file_paths
      @notifier_file_paths = [Pathname('../notifiers/*.rb')]
    end

    def require_notifiers
      Dir[*notifier_file_paths].each {|f| require f }
    end

    private

    def use?(notifier)
      using_notifiers.include?(notifier.to_s)
    end

    def using_notifiers
      yaml = YAML.load_file('../../lib/notifier.yml')
      yaml['notifiers']
    end
  end
end
