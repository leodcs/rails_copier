module RailsCoppier
  class String
    def underscore
      self.scan(/[A-Z][a-z]*/).join("_").downcase
    end
  end
end
