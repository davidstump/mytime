module Mytime
  extend self

  # Create .mytime file in the profile directory 
  #   and insert the user account and Freshbooks token
  #
  def setup
    puts "What is your Freshbooks account name?" 
    account_name = STDIN.gets.chomp
    puts "What is your Freshbooks token?" 
    token = STDIN.gets.chomp
    account = Hash.new
    account["account"] = "#{account_name}.freshbooks.com"
    account["token"] = token
    Config.save(account)
  end

  # Setup .mytime file to include project specific data
  #
  def init
    puts "Choose Project:"
    projects = Client.project["project"]
    projects.each do |project|
      puts "#{project['project_id']}: #{project['name']}"
    end
    project_id = STDIN.gets.chomp

    project = Client.project(project_id)["project"]
    task_id = project["tasks"]["task"][0]["task_id"]

    project_details = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    project_details[project_id]["project_path"] = Dir.pwd
    project_details[project_id]["project_id"] = project_id
    project_details[project_id]["task_id"] = task_id
    Config.add(project_details)
  end

  # Set configuration variables to values passed in the command line options
  #
  def parse_options(*args)
    options = OptionParser.new do |opts|
      opts.banner = "\nUsage: mytime [options] [command]"
      opts.separator "mytime uses git to log your time\n\n"
      opts.separator "Commands:"
      opts.separator "  status    Prints formatted commit log from today"
      opts.separator "  setup     Sets up mytime authorization information"
      opts.separator "  init      Sets up mytime for this project"
      opts.separator "  commit    Creates a custom timesheet entry"
      opts.separator "  push      Saves timesheet entry with git commit log"
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