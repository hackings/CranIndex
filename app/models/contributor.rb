class Contributor < ActiveRecord::Base
  has_many :package_contributors
  	
  validates :name, presence: true
end
