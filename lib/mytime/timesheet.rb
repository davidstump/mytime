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
  #   hours: Required - number of hours for this time entry
  #   message: Optional - custom message to send with time entry
  #
  def commit(hours, message = "")
    puts "Submitting: #{message}"
    puts Client.submit(hours, message)
  end

  # Send git commit log as timesheet entry to client
  #
  # Options
  #   hours: Required parameter for number of hours on time entry
  #
  def push(hours)
    puts Client.submit(hours, status)
  end

end