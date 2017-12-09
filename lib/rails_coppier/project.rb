module RailsCoppier
  class Project
    attr_accessor :new_name, :folder_name, :from, :to

    def self.create(from, to)
      new(from: from, to: to).save
    end

    def initialize(from, to)
      print 'Please type the NEW project name (in CamelCase): '
      @new_name = gets.chomp
      @new_dir  = Folder.new(new_name.underscore).save
      @from     = from
      @to       = to
    end

    def save
      FileUtils.copy_entry(Folder.current, @new_dir)
      replace_rails_secret
      remove_self_from_copy
      replace_old_name_ocurrencies
    end

    private

    def replace_rails_secret
      data = YAML.load_file(Folder.path_to_secrets)
      new_secret = `bundle exec rails secret`
      data["development"]["secret_key_base"] = new_secret.chomp
      File.open(Folder.path_to_secrets, 'w') { |f| f.write(data.to_yaml) }
    end

    def remove_self_from_copy
      FileUtils.rm("#{@new_dir}/#{File.basename(__FILE__)}")
    end

    def replace_old_name_ocurrencies
      exec(
          "grep -r -l #{old_name} #{@new_dir} |
          sort |
          uniq |
          xargs perl -e 's/#{old_name}/#{new_name}/' -pi"
      )
    end

    def old_name
      file_path = "#{Folder.current}/config/application.rb"
      File.open(file_path).each do |line|
        return line.chomp.gsub('module ', '') if line.include?("module")
      end
    end
  end
end
