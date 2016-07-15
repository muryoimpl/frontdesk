require 'bundler'

module FrontDesk
  Bundler.require
  Config.load_and_set_settings('./settings.yml')

  include PiPiper

  def root
    Dir.pwd
  end
end

require 'notifier'
require 'notifier_runner'
require 'work'
require 'seat'
require 'sensors/distance_sensor'
