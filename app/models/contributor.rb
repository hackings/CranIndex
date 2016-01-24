class Contributor < ActiveRecord::Base
  has_many :package_contributors
  	
  validates :name, presence: true

  def name_with_email
  	return name if email.blank?
  	"#{name} <#{email}>"
  end 	
end
