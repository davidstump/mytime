module Mytime
  extend self

  def status
    user = `git config --get user.name`
    system("git log --oneline --author='#{user}' --since='6am'")
  end

  def commit(message = "")
    puts "added: #{message.to_s}"
    account = self.get_account_details    
    puts account["account"], account["token"]
    c = FreshBooks::Client.new(account["account"], account["token"])
    puts c.time_entry.create(
      :time_entry => {
        project_id: 1,
        task_id: 1,
        hours: 4.5,
        notes: 'Git Commit History',
        date: Date.today.to_s
      }
    )
  end

end