class FrontDesk::Notifier
  class << self
    def subclasses
      @subclasses ||= []
    end

    def inherited(base)
      base.subclasses << base
    end

    def instance
      @instance ||= new
    end
  end

  def notify
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
