module Mytime

  module Client
    extend self

    def save(message = "")
      account = Mytime.get_account_details    
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