require 'rails_helper'

  RSpec.describe Customer, type: :model do
    
    subject(:customer) { create(:customer) }
    it { should respond_to(:name) }
    it { should respond_to(:cuit) }
    it { should respond_to(:address) }
    it { should have_many(:customer_ca_movements)}
    it { should validate_presence_of(:name) }


end
