require 'rails_helper'

  describe SaleDetail, type: :model do
    
    subject { create :sale_detail }
    it { should respond_to(:iva) }
    it { should respond_to(:unit_price) }
    it { should respond_to(:quantity) }
    it { should belong_to(:sale)}
    it { should validate_presence_of(:iva) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:sale) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:iva).is_greater_than_or_equal_to(0) }

    context "#subtotal" do
      its(:subtotal) { should eq 121 }
    end



end
