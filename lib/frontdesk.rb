require 'bundler'

module FrontDesk
  Bundler.require
  Config.load_and_set_settings('./settings.yml')

  include PiPiper

  autoload :Notifier,       'notifier'
  autoload :NotifierRunner, 'notifier_runner'
  autoload :Work,           'work'
end
