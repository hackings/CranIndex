class Package < ActiveRecord::Base
  validates :name, :version, presence: true
  validates :name, uniqueness: { scope: :version }
end
