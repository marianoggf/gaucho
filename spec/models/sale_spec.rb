require 'rails_helper'

  describe Sale, type: :model do
    before(:all) { ::CustomerCaMovement } 
    subject { create(:sale, sale_details: [build(:sale_detail, unit_price: 100, quantity: 10, iva: 21, sale: nil), build(:sale_detail, unit_price: 200, quantity: 20, iva: 21, sale: nil)]) }
    it { should respond_to(:date) }
    it { should belong_to(:customer_ca_movement)}
    it { should belong_to(:customer)}
    it { should have_many(:sale_details).dependent(:destroy) }
    it { should accept_nested_attributes_for(:sale_details).allow_destroy(true) }
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
      it { expect{ subject.destroy }.to change{ CustomerCaMovement.count }.by(-1) }
      it { expect{ subject.destroy }.to change{ customer.total }.from(-6050).to(0) }
      it_behaves_like 'self returner when destroyed'     
    end

end
