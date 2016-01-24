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

  #Instance Methods
  it "should return `authers_name` for package" do 
    autor1 = FactoryGirl.create(:contributor, name: 'John Doh', email: 'john@sample.com')
    autor2 = FactoryGirl.create(:contributor, name: 'Foo Bar', email: 'foo@bar.com')
    package = FactoryGirl.create(:package)
    package.package_authors << autor1
    package.package_authors << autor2
    expect(package.authers_name).to eq("John Doh <john@sample.com>, Foo Bar <foo@bar.com>")
  end   

  it "should return `maintainers_name` for package" do 
    maintainer1 = FactoryGirl.create(:contributor, name: 'John Doh', email: 'john@sample.com')
    maintainer2 = FactoryGirl.create(:contributor, name: 'Foo Bar', email: 'foo@bar.com')
    package = FactoryGirl.create(:package)
    package.package_maintainers << maintainer1
    package.package_maintainers << maintainer2
    expect(package.maintainers_name).to eq("John Doh <john@sample.com>, Foo Bar <foo@bar.com>")
  end   

end
