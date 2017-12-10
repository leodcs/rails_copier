require 'fileutils'
require 'yaml'
require 'sudo'

module RailsCoppier
  class Project
    def self.create(from, to, new_name)
      new(from, to, new_name).save
    end

    def initialize(from, to, new_name)
      @folder  = Folder.create(from, to, new_name)
    end

    def save
      copy_entry
      replace_old_name_ocurrencies
      remove_git_repo
      remove_tmp
      replace_rails_secret
      touch_log_folder
      remove_database_yml
      self
    end

    private

    def copy_entry
      Sudo::Wrapper.run do |sudo|
        sudo[FileUtils].copy_entry(@folder.from, @folder.new_dir)
      end
    end

    def replace_rails_secret
      data = YAML.load_file(@folder.path_to_secrets)
      data["development"]["secret_key_base"] = bundle_exec_secret
      Sudo::Wrapper.run do |sudo|
        sudo[File].write(@folder.path_to_secrets, data.to_yaml)
      end
    end

    def replace_old_name_ocurrencies
      `sudo grep -r -l #{old_name} #{@folder.new_dir} |
       sudo sort |
       sudo uniq |
       sudo xargs perl -e 's/#{old_name}/#{@folder.new_name}/' -pi`
    end

    def old_name
      file_path = "#{@folder.from}/config/application.rb"
      File.open(file_path).each do |line|
        return line.chomp.gsub('module ', '') if line.include?("module")
      end
    end

    def remove_git_repo
      Sudo::Wrapper.run do |sudo|
        git_ignore = "#{@folder.new_dir}/.gitignore"
        git_dir = "#{@folder.new_dir}/.git"
        sudo[FileUtils].rm(git_ignore) if File.exist?(git_ignore)
        sudo[FileUtils].rm_rf(git_dir) if Dir.exist?(git_dir)
      end
    end

    def remove_tmp
      Sudo::Wrapper.run do |sudo|
        tmp = "#{@folder.new_dir}/tmp"
        sudo[FileUtils].rm_rf(tmp) if Dir.exist?(tmp)
      end
    end

    def bundle_exec_secret
      Dir.chdir(@folder.new_dir) do
        secret = `bundle exec rake secret`
        raise "Unable to run 'bundle exec' on #{@folder.new_dir}" if secret.empty?
        return secret.chomp
      end
    end

    def touch_log_folder
      Sudo::Wrapper.run do |sudo|
        Dir["#{@folder.new_dir}/log/**.log"].each { |file| sudo[File].truncate(file, 0) }
      end
    end

    def remove_database_yml
      Sudo::Wrapper.run do |sudo|
        database_yml = "#{@folder.new_dir}/config/database.yml"
        sudo[FileUtils].rm(database_yml) if File.exist?(database_yml)
      end
    end
  end
end
