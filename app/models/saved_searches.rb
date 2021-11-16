class SavedSearches < ApplicationRecord
  acts_as_paranoid

  belongs_to :library
 
  validates :name, presence: true
end
