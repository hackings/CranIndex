require 'rails_helper'

RSpec.describe Contributor, type: :model do
  
  it { 
  	#Validations
  	should validate_presence_of( :name )
    
    #Associations 
  	should have_many( :package_contributors )
  }

  #Instance Methods
  it "should return `name_with_email` only name for email blank" do 
    contributor = FactoryGirl.create(:contributor, name: 'Foo Bar', email: nil)
    expect(contributor.name_with_email).to eq("Foo Bar")
  end   

  it "should return `name_with_email` both name and email" do 
    contributor = FactoryGirl.create(:contributor, name: 'John Doh', email: 'john@sample.com')
    expect(contributor.name_with_email).to eq("John Doh <john@sample.com>")
  end   

end
