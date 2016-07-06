require 'net/http'

class FrontDesk::IdobataNotifier < FrontDesk::Notifier
  def enter
    puts 'enter idobata '
  end

  def leave
    puts 'leave idobata'
  end

  private

  def http_client
  end
end
