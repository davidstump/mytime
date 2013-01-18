# MyTime

Use your git commit history to track your time. Uses Freshbooks API.

## Installation

Add this line to your application's Gemfile:

    gem 'mytime'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mytime

## Usage

  To link to your Freshbooks account (you will need your Freshbooks username and API token):
  
    $ mytime setup

  To initialize mytime in a project directory:
  
    $ mytime init

  To see project details:
  
    $ mytime project

  To list log:

    $ mytime status

  To submit custom time entry:

    $ mytime commit [hrs] [custom_message]
    $ mytime commit  1.5 "Add an additional note if desired"

  To push your git logs from today for a given project:
  
    $ mytime push [hrs] [optional_message]
    $ mytime push 4.5 "Insert slot A into slot B"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
