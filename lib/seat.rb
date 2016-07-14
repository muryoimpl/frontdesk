class FrontDesk::Seat
  attr_reader :distance, :last_distance, :state

  def distance=(value)
    @last_distance, @distance = @distance, value
  end

  def enter?
    if (@last_distance.nil? && @distance > reference_distance)
      return false
    end

    if (@last_distance.nil? && @distance <= reference_distance) ||
      (@last_distance > reference_distance && @distance < reference_distance)
      @state = :enter
      true
    end
  end

  def leave?
    return false unless @last_distance

    if @last_distance < reference_distance && @distance > reference_distance
      @state = :leave
      true
    end
  end

  private

  def reference_distance
    Settings.room.distance
  end
end
