module Mytime

  module Client
    extend self

    # Get project data from client API
    #
    # Option:
    #   project_id: Optional project_id to restrict data returned
    #
    def project(project_id = nil)
      account = Config.details    
      c = FreshBooks::Client.new(account["account"], account["token"])
      if project_id.nil?
        c.project.list["projects"]
      else
        c.project.get :project_id => project_id
      end
    end

    # Get task data from client API
    #
    # project_id: Required project_id to restrict data returned
    #
    def tasks(project_id)
      account = Config.details    
      c = FreshBooks::Client.new(account["account"], account["token"])
      c.task.list :project_id => project_id
    end

    # Submit new time entry to client API
    #
    # Option:
    #   hours: Required - number of hours spent for this time entry
    #   message: Optional - message to send with time entry
    #
    def submit(hours, message = "")

      account = Config.details
      c = FreshBooks::Client.new(account["account"], account["token"])
      project = Config.details(Dir.pwd)
      entry = c.time_entry.create(
        :time_entry => {
          project_id: project["project_id"],
          task_id: project["task_id"],
          hours: hours.to_f,
          notes: message.gsub(/\n/,"\n\n").to_s,
          date: Date.today.to_s
        }
      )
      return validate(entry)
    end

    # Validate time entry to establish API success or failure
    #
    # Option
    #   entry: Required time entry parameter to validate
    #
    def validate(entry)
      return "Oops. Please try resubmitting your time or checking accout details!" unless entry.any?
      if entry["time_entry_id"]
        return "Timesheet Successfully Submitted"
      else
        return "Oops. An error was encountered: #{entry}"
      end
    end

  end

end