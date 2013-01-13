module Mytime
  extend self

  # Return log of git commits from today
  #
  def status
    user = `git config --get user.name`
    `git log --oneline --author='#{user}' --since='6am'`
  end

  # Send a custom time entry to API with string message
  #
  # Option:
  #   message: Optional custom message to send with time entry
  #
  def commit(message = "")
    puts "Submitting: #{message}"
    puts Client.submit(message)
  end

  # Send git commit log as timesheet entry to client
  #
  def push
    puts Client.submit(status)
  end

end