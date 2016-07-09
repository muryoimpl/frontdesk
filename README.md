# frontdesk
Monitor whether you sit on your seat with Raspberry Pi

## Requirement

You need Raspberry Pi which is installed Ruby 2.3.x, and HC-SR501.

## Installation

Clone frontdesk in Raspberry Pi and execute `bundle install`.

```
$ git clone git@github.com:muryoimpl/frontdesk.git
$ cd frontdesk
$ bundle install
```

And write configuration in `settings.yml`.

```yaml
# write GPIO pin number
pins:
  infrared_sensor: 18

# `name` is the room name which you want monitor.
room:
  name: ジビエルーム（左）

# add your Notification classes which you want to use.
notifiers:
  - FrontDesk::IdobataNotifier

# if you use idobata nofifier, replace `url` with your idobta room's hook url.
idobata:
  url: 'hook url'

```

## Usage

```
$ sudo bin/frontdesk
```
