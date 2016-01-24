require 'rails_helper'

RSpec.describe Package, type: :model do
  it { 
  	#Validations
  	should validate_presence_of( :name )
  	should validate_presence_of( :version )
  	should validate_uniqueness_of( :name ).scoped_to( :version )

  	#Associations 
  	should have_many( :package_contributors )
  	should have_many( :package_authors ).through( :package_contributors ).source( :contributor).conditions( package_contributors: { contributor_type: 'Author'} )
  	should have_many( :package_maintainers ).through( :package_contributors ).source( :contributor).conditions( package_contributors: { contributor_type: 'Maintainer'} )
  }
end
