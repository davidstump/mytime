module Mytime

  module Config
    extend self

    # Return details of .mytime config file
    #
    def details(path = "")
      begin
        data = YAML.load_file USER_FILE
        if path == ""
          data
        else
          data.each do |d|
            project = data.select{|key, hash| hash["project_path"] == path }
            return project.first[1] if project.any?
          end
        end
      rescue Exception => e
        {}
      end
    end

    # Save a .mytime config file. Overwrites any existing data
    # 
    # Options:
    #   contents: Required hash of account data to save
    #
    def save(contents)
      begin
        File.open(USER_FILE, 'a') do |file|
          file.write contents.to_yaml
        end
      rescue
        puts "Failed saving information! Please try again."
      end
    end

    # Add yaml data to the existing .mytime config file
    #
    # Options:
    #   contents: Required hash of data to add to config file
    #
    def add(contents)
      begin
        data = YAML.load_file USER_FILE
        merged_data = data.merge(contents)
        puts merged_data
        File.open(USER_FILE, 'w') do |file|
          file.write merged_data.to_yaml
        end
      rescue
        puts "Failed adding data. Please try again."
      end
    end

  end

end