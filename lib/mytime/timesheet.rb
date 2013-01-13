module Mytime
  extend self

  def status
    user = `git config --get user.name`
    `git log --oneline --author='#{user}' --since='6am'`
  end

  def commit(message = "")
    puts "Submitting: #{message}"
    puts Client.save(message)
  end

  def push
    message = status.gsub(/\\n/, "\n\n")
    puts Client.save(message)
  end

end