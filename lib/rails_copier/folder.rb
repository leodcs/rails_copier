module RailsCopier
  class Folder
    attr_accessor :new_name, :new_dir, :from, :to

    def self.create(from, to, new_name)
      new(from, to, new_name).save
    end

    def initialize(from, to, new_name)
      @new_name = new_name
      @from     = from
      @to       = to
    end

    def save
      @new_dir = FileUtils::mkdir_p("#{to}/#{new_name.underscore}").join
      self
    end

    def path_to_secrets
      "#{new_dir}/config/secrets.yml"
    end
  end
end
