require 'rails_helper'

describe CustomerCaMovement, type: :model do

  subject { create(:customer_ca_movement, amount: 10000, customer_ca_movement_type: CustomerCaMovementType.find(1)) }
  let(:customer) { create(:customer, total: 10000)}
  it { should respond_to(:amount) }
  it { should respond_to(:previous_balance) }
  it { should respond_to(:date) }
  it { should respond_to(:following)}
  it { should respond_to(:previous)}
  it { should belong_to(:customer)}
  it { should belong_to(:customer_ca_movement_type)}
  it { should have_one(:sale).dependent(true)}
  it { should validate_presence_of(:customer_ca_movement_type) }  
  it { should validate_presence_of(:date) } 
  it { should validate_presence_of(:amount) } 
  it { should validate_presence_of(:customer) }

  context '#previous_balance' do
    it 'populates previous_balance if blank before savings' do
      subject.previous_balance = nil
      subject.save
      expect(subject.previous_balance).not_to be_nil
    end
  end

  context '#calculate_ca_total (private method)' do
    let(:movement_1) { create(:customer_ca_movement, amount: 1000, customer: customer, customer_ca_movement_type: CustomerCaMovementType.find(1))}
    let(:movement_2) { create(:customer_ca_movement, amount: 2000, customer: customer, customer_ca_movement_type: CustomerCaMovementType.find(2))}
    let(:two_movements) do
      movement_1
      movement_2
    end

    context 'customers total' do
      it { expect(customer.total).to eq(10000) }
      it { expect{movement_1}.to change{ customer.total }.from(10000).to(11000)}
      it { expect{two_movements}.to change{ customer.total }.from(10000).to(9000)}
    end

    context 'customer movements total count' do
      it { expect{movement_1}.to change{ CustomerCaMovement.count }.from(0).to(1)}
      it { expect{two_movements}.to change{ CustomerCaMovement.count }.from(0).to(2)}
    end

    context 'with multiple savings' do
      before do
        movement_1.save
        movement_1.save
        movement_1.save
      end
      it { expect(customer.total).to eq 11000 }
      context 'and updates' do
        before { movement_1.update(amount: 5000) }
        it { expect(customer.total).to eq 15000 }
      end
    end
  end


  context 'concerning neighbours' do
    let!(:previous) { create(:customer_ca_movement, amount: 100, customer_ca_movement_type: CustomerCaMovementType.find(1))}
    let!(:middle) {  create(:customer_ca_movement, amount: 200, customer_ca_movement_type: CustomerCaMovementType.find(1)) }
    let!(:following) { create(:customer_ca_movement, amount: 1000, customer_ca_movement_type: CustomerCaMovementType.find(1))}

    context '#previous' do
      context 'without previous movement' do
        subject{ previous }
        its(:previous) { should be nil}
        its(:previous_balance) { should eq 0 }
      end
      context 'with previous movement' do
        subject { middle }
        its(:previous) { should eq(previous) }
        its(:previous_balance) { should eq 100 }
      end
    end

    context '#following' do
      context 'without following movement' do
        subject { following }
        its(:following) { should be nil}
        its(:previous_balance) { should eq 300 }
      end
      context 'with following movement' do    
        subject{ middle }    
        its(:following) { should eq(following) }
        its(:previous_balance) { should eq 100 }
      end
    end
  end

  context '#destroy' do
    before {subject}
    let(:customer) { subject.customer }
    it { expect{ subject.destroy }.to change{ CustomerCaMovement.count }.from(1).to(0) }
    it { expect{ subject.destroy }.to change{ customer.total }.from(10000).to(0) }
    context 'with sale associated' do
      let!(:sale) { create(:sale, sale_details: [build(:sale_detail, unit_price: 100, quantity: 10, iva: 21, sale: nil)])}
      subject(:customer_ca_movement) { sale.customer_ca_movement }
      it { expect{subject.destroy}.to change{ CustomerCaMovement.count }.from(1).to(0) }
      it { expect{subject.destroy}.to change{ Sale.count }.from(1).to(0) }
      it { expect{subject.destroy}.to change{subject.customer.total}.from(-1210).to(0)  }
      it { expect(subject.destroy).to equal(subject) }
      it { expect(subject.errors.first).to eq nil }        
    end
  end
  
end
