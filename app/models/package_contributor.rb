class PackageContributor < ActiveRecord::Base
  belongs_to :package
  belongs_to :contributor

  validates :package, :contributor, presence: true
end
