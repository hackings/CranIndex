class Package < ActiveRecord::Base
  has_many :package_contributors  

  validates :name, :version, presence: true
  validates :name, uniqueness: { scope: :version }
end
