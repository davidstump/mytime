module Mytime

  module Client
    extend self

    # Get project data from client API
    #
    # Option:
    #   project_id: Optional project_id to restrict data returned
    #
    def project(project_id = nil)
      account = config_details    
      c = FreshBooks::Client.new(account["account"], account["token"])
      if project_id.nil?
        c.project.list["projects"]
      else
        c.project.get :project_id => project_id
      end
    end

    # Submit new time entry to client API
    #
    # Option:
    #   message: Optional message to send with time entry
    #
    def submit(message = "")
      account = config_details  
      c = FreshBooks::Client.new(account["account"], account["token"])
      entry = c.time_entry.create(
        :time_entry => {
          project_id: 1,
          task_id: 1,
          hours: 4.5,
          notes: message.to_s,
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