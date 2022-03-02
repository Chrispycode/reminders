class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def better_errors
    self.errors.reduce("") { |errors, e| errors << "#{e.attribute.capitalize} #{e.message}" }
  end
end
