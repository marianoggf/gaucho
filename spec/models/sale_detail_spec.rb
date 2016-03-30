require 'rails_helper'

  RSpec.describe SaleDetail, type: :model do
    
    subject { create(:sale_detail, unit_price: 100, quantity: 10, iva: 21) }
    it { should respond_to(:iva) }
    it { should respond_to(:unit_price) }
    it { should respond_to(:quantity) }
    it { should belong_to(:sale)}
    it { should validate_presence_of(:iva) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:sale) }

    context "#subtotal" do
      its(:subtotal) { should eq 1210 }
    end



end
