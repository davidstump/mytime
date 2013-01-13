require "mytime/version"
require "mytime/setup"
require "mytime/client"
require "mytime/timesheet"
require 'ruby-freshbooks'
require 'optparse'
require 'yaml'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

module Mytime
    extend self
    extend Mytime::Client

    USER_FILE = File.expand_path('~/.mytime')

    # Parses command line arguments and does what needs to be done.
    #
    # @returns nothing
    def execute(*args)
      @options = parse_options(*args)
      command = args.shift || 'list'

      case command.to_sym
      when :setup
        puts "We have all the time in the world."
        setup
      when :init
        init
      when :status, :list, :log
        puts status
      when :commit, :add, :a
        commit(args.first, args.last)
      when :push, :submit, :p 
        puts "Submitting Timesheet..."
        push(args.first)
      when :project, :detail, :info
        puts "Project Details:"
        puts config_details(Dir.pwd).to_yaml
      else
        puts @options
      end
    end

    # Save a .mytime config file. Overwrites any existing data
    # 
    # Options:
    #   contents: Required hash of account data to save
    #
    def save(contents)
      File.open(USER_FILE, 'a') do |file|
        file.write contents.to_yaml
      end
    end

    # Add yaml data to the existing .mytime config file
    #
    # Options:
    #   contents: Required hash of data to add to config file
    #
    def add(contents)
      data = YAML.load_file USER_FILE
      merged_data = data.merge(contents)
      puts merged_data
      File.open(USER_FILE, 'w') do |file|
        file.write merged_data.to_yaml
      end
    end

    # Return details of .mytime config file
    #
    def config_details(path = "")
      return unless YAML.load_file(USER_FILE)
      data = YAML.load_file USER_FILE
      if path == ""
        data
      else
        data.each do |d|
          project = data.select{|key, hash| hash["project_path"] == path }
          return project.first[1]
        end
      end
    end

end
