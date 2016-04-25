require 'rails_helper'

  describe CustomerCaMovementType, type: :model do

    it { should respond_to(:name) }
    it { should have_many(:customer_ca_movements)}
    it { should validate_presence_of(:name) } 

end
