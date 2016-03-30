require 'rails_helper'

  RSpec.describe Sale, type: :model do
    
    subject { create(:sale, sale_details: [build(:sale_detail, unit_price: 100, quantity: 10, iva: 21, sale: nil), build(:sale_detail, unit_price: 200, quantity: 20, iva: 21, sale: nil)]) }
    it { should respond_to(:date) }
    it { should respond_to(:prescription_date) }
    it { should belong_to(:customer_ca_movement)}
    it { should belong_to(:customer)}
    it { should have_many(:sale_details).dependent(:destroy) }
    it { should validate_presence_of(:date) }

    context '#total' do
      its(:total) { should eq 6050 }
    end

    context '#customer_ca_movement' do
      it { expect{subject}.to change{CustomerCaMovement.count }.from(0).to(1) }
      its('customer_ca_movement.amount') { should eq subject.total }
    end

    context '#destroy' do
      before {subject}
      let(:customer) { subject.customer_ca_movement.customer }
      its(:destroy) { should eq false }
      it { expect{ subject.destroy }.not_to change{ CustomerCaMovement.count }.from(1) }
      it { expect{ subject.destroy }.not_to change{ customer.total }.from(-6050) }
    end

end
