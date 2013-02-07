require "mytime/version"
require "mytime/setup"
require "mytime/config"
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
        puts Config.details(Dir.pwd).to_yaml
      when :debug
        puts init?
      else
        puts @options
      end
    end

    # Check if mytime is setup
    def setup?
      Config.details.has_key?("account")
    end

    # Check if mytime is initialized for this project
    def init?
      Config.details(Dir.pwd).has_key?("project_id")
    end

    def finish_setup
      return puts "Please run `mytime setup` connect your account." unless setup?
      return puts "Please run `'mytime init` to setup this project directory" unless init?
    end

end
