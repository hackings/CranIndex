class Contributor < ActiveRecord::Base
  validates :name, presence: true
end
