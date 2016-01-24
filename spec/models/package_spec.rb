require 'rails_helper'

RSpec.describe Package, type: :model do
  it { 
  	#Validations
  	should validate_presence_of( :name )
  	should validate_presence_of( :version )
  	should validate_uniqueness_of( :name ).scoped_to( :version )

  	#Associations 
  	should have_many( :package_contributors )
  }
end
