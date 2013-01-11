module Mytime
  extend self

  # Create .mytime file in the profile directory 
  #   and insert the user account and Freshbooks token
  #
  def init
    puts "What is your Freshbooks account url?" 
    account = STDIN.gets.chomp
    puts "What is your Freshbooks token?" 
    token = STDIN.gets.chomp
    contents = ["account" => account, "token" => token]
    self.save(contents)
  end

  # Set configuration variables to values passed in the command line options
  #
  def parse_options(*args)
    options = OptionParser.new do |opts|
      opts.banner = "\nUsage: mytime [options] [command]"
      opts.separator "mytime uses git to log your time\n\n"
      opts.separator "Commands:"
      opts.separator "  list      Prints all items"
      opts.separator "  init      Bootstraps tacos in this directory"
      opts.separator ""
      opts.separator "Options:"
      opts.on('-h', '--help', 'Display this screen') { puts opts; exit }
      opts.on('-v', '--version', 'Display the current version') do
        puts Mytime::VERSION
        exit
      end
    end
    options.parse!(args)
    options
  end
end