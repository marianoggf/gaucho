require 'rails_helper'

describe CustomerCategory, type: :model do
    
  subject(:customer_category) { create(:customer_category) }
  it { should respond_to(:name) }
  it { should have_many(:customers)}
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  its(:destroy) { should eq false }
end
