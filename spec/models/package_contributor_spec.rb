require 'rails_helper'

RSpec.describe PackageContributor, type: :model do
  it { 
  	#Validations
  	should validate_presence_of( :package )
  	should validate_presence_of( :contributor )

  	#Associations 
  	should belong_to( :package )
  	should belong_to( :contributor )
  }
end
