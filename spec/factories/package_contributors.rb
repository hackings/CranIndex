FactoryGirl.define do
  factory :package_author do
    association :package
    association :contributor
    contributor_type "Author"
  end

  factory :package_maintainer do
    association :package
    association :contributor
    contributor_type "Maintainer"
  end

end
