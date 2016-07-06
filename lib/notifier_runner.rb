require 'notifier'

class FrontDesk::NotifierRunner
  class << self
    def run
      require_notifiers

      Notifier.subclasses(&:notify)
    end

    def notifier_file_paths
      @notifier_file_paths = [Pathname('..', 'notifiers', '*.rb')]
    end

    def require_notifiers
      Dir[*notifier_file_paths].each {|f| require f }
    end
  end
end
