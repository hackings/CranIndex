require 'rails_helper'

RSpec.describe Contributor, type: :model do
  
  it { 
  	#Validations
  	should validate_presence_of( :name )
  }

end
