class FrontDesk::Notifier
  class << self
    def subclasses
      @subclasses ||= []
    end

    def inherited(base)
      base.superclass.subclasses << base
    end

    def instance
      @instance ||= new
    end
  end

  protected

  def enter
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def leave
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
