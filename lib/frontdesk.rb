require 'bundler'

module FrontDesk
  GPIO_PIN_18 = 18

  Bundler.require

  include PiPiper

  autoload :Notifier,       'notifier'
  autoload :NotifierRunner, 'notifier_runner'
  autoload :Work,           'work'
end
