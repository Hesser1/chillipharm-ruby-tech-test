require 'rails_helper'

RSpec.describe SavedSearches do
  it { should validate_presence_of(:name) }
end
