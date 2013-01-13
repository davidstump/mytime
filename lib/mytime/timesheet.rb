module Mytime
  extend self

  def status
    user = `git config --get user.name`
    system("git log --oneline --author='#{user}' --since='6am'")
  end

  def commit(message = "")
    puts "Submitting: #{message}"
    account = self.get_account_details    
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
    puts validate(entry)
  end

  def push(message = "")
    account = self.get_account_details    
    c = FreshBooks::Client.new(account["account"], account["token"])
    puts c.time_entry.create(
      :time_entry => {
        project_id: 1,
        task_id: 1,
        hours: 4.5,
        notes: status,
        date: Date.today.to_s
      }
    )
  end

  def validate(entry)
    return "Oops. Please try resubmitting your time or checking accout details!" unless entry.any?
    if entry["time_entry_id"]
      return "Timesheet Submitted"
    else
      return "Oops. An error was encountered: #{entry}"
    end
  end

end