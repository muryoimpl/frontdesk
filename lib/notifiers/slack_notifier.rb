class FrontDesk::SlackNotifier < FrontDesk::Notifier
  def enter
    puts 'enter slack'
    Slack::Notifier.new(Settings.slack.url).ping("#{Settings.room.name}に着席しました。")
  end

  def leave
    puts 'leave slack'
    Slack::Notifier.new(Settings.slack.url).ping("#{Settings.room.name}から離席しました。")
  end
end
