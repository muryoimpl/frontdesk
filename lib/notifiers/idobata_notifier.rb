require 'net/http'

class FrontDesk::IdobataNotifier < FrontDesk::Notifier
  def enter
    puts 'enter idobata'
    Net::HTTP.post_form URI.parse(Settings.idobata.url), source: source_of_entry,  format: :html
  end

  def leave
    puts 'leave idobata'
    Net::HTTP.post_form URI.parse(Settings.idobata.url), source: source_of_exit,  format: :html
  end

  private

  def source_of_entry
    <<~HTML
      #{Settings.room.name} に着席しました。
    HTML
  end

  def source_of_exit
    <<~HTML
      #{Settings.room.name} から離席しました。
    HTML
  end
end
