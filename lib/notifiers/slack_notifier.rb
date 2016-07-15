class FrontDesk::SlackNotifier < FrontDesk::Notifier
  def initialize
    @slack ||= Slack::Notifier.new(Settings.slack.url)
  end

  def enter
    puts 'enter slack'
    @slack.ping("#{Settings.room.name}に着席しました。")
  end

  def leave
    puts 'leave slack'
    @slack.ping("#{Settings.room.name}から離席しました。")
  end
end
