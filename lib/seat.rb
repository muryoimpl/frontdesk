class FrontDesk::Seat
  attr_reader :distance, :last_distance

  def distance=(value)
    @last_distance, @distance = @distance, value
  end

  def enter?
    return true unless @last_distance

    (@last_distance.nil? && @distance < reference_distance) ||
      (@last_distance > reference_distance && @distance < reference_distance)
  end

  def leave?
    return false unless @last_distance

    @last_distance < reference_distance && @distance > reference_distance
  end

  private

  def reference_distance
    Settings.room.distance
  end
end
