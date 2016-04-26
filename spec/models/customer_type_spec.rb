require 'rails_helper'

describe CustomerType, type: :model do
    
  subject(:customer_type) { create(:customer_type) }
  it { should respond_to(:name) }
  it { should have_many(:customers)}
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  its(:destroy) { should eq false }
end
