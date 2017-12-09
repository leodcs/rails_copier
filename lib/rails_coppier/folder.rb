module RailsCoppier
  class Folder
    attr_accessor :folder_name

    def initialize(folder_name)
      @folder_name = folder_name
    end

    def save
      FileUtils::mkdir_p("#{Folder.parent}/#{folder_name}").join
    end

    def self.current
      Dir.pwd
    end

    def self.parent
      File.expand_path("..", Folder.current)
    end

    def self.path_to_secrets
      "#{Folder.current}/config/secrets.yml"
    end
  end
end
