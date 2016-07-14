class FrontDesk::YukkuriNotifier < FrontDesk::Notifier
  def enter
    puts 'enter'
    system 'aplay ./lib/notifiers/sounds/enter.wav'
  end

  def leave
    puts 'leave'
    system 'aplay ./lib/notifiers/sounds/leave.wav'
  end
end
