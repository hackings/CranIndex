require 'rails_helper'

RSpec.describe Contributor, type: :model do
  
  it { 
  	#Validations
  	should validate_presence_of( :name )
    
    #Associations 
  	should have_many( :package_contributors )
  }

end
