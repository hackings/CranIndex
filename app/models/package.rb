class Package < ActiveRecord::Base
  has_many :package_contributors  
  has_many :package_authors, ->{ where(package_contributors: { contributor_type: 'Author'} ) }, 
    source: :contributor, through: :package_contributors
  has_many :package_maintainers, ->{ where(package_contributors: { contributor_type: 'Maintainer'} ) }, 
    source: :contributor, through: :package_contributors
  

  validates :name, :version, presence: true
  validates :name, uniqueness: { scope: :version }

  def authers_name
    package_authors.collect(&:name_with_email).join(", ")	
  end 	

  def maintainers_name
    package_maintainers.collect(&:name_with_email).join(", ")	
  end 	
  
end
