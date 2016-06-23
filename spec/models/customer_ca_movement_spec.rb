require 'rails_helper'

describe CustomerCaMovement, type: :model do

  subject { create(:customer_ca_movement, amount: 10000, customer_ca_movement_category: CustomerCaMovementCategory.find(1)) }
  let(:customer) { create(:customer)}
  it { should respond_to(:amount) }
  it { should respond_to(:previous_balance) }
  it { should respond_to(:date) }
  it { should respond_to(:following)}
  it { should respond_to(:previous)}
  it { should belong_to(:customer)}
  it { should belong_to(:customer_ca_movement_category)}
  it { should have_one(:sale).dependent(true)}
  it { should validate_presence_of(:customer_ca_movement_category) }  
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

  context 'concerning neighbours' do
    let(:customer) { create :customer }
    context "with three movements" do
      let!(:previous) { create(:customer_ca_movement, amount: 100, customer_ca_movement_category_id: 1, customer: customer, date: oldest_date)}
      let!(:middle) {  create(:customer_ca_movement, amount: 200, customer_ca_movement_category_id: 1, customer: customer, date: middle_date) }
      let!(:following) { create(:customer_ca_movement, amount: 1000, customer_ca_movement_category_id: 1, customer: customer, date: newest_date)}
      context "with the same date" do
        let(:oldest_date) { DateTime.now}
        let(:middle_date) { DateTime.now}
        let(:newest_date) { DateTime.now}
        it_behaves_like 'neighbour'
      end
      context "with the different dates date" do
        let(:oldest_date) { DateTime.now - 1.second}
        let(:middle_date) { DateTime.now}
        let(:newest_date) { DateTime.now + 1.second} 
        it_behaves_like 'neighbour'    
      end
    end
    context "with mixed dates" do
      let!(:first) { create(:customer_ca_movement, amount: 100, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now - 1.second)}
      let!(:second) { create(:customer_ca_movement, amount: 200, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now - 1.second)}
      let!(:third) { create(:customer_ca_movement, amount: 300, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now)}
      let!(:fourth) {  create(:customer_ca_movement, amount: 400, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now) }
      let!(:fifth) { create(:customer_ca_movement, amount: 500, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now)}
      let!(:sixth) { create(:customer_ca_movement, amount: 600, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now + 1.second)}
      let!(:seventh) { create(:customer_ca_movement, amount: 700, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now + 1.second)}
      context "#previous" do
        it { expect(first.previous).to eq nil }
        it { expect(second.previous).to eq first }
        it { expect(third.previous).to eq second }
        it { expect(fourth.previous).to eq third }
        it { expect(fifth.previous).to eq fourth }
        it { expect(sixth.previous).to eq fifth }
        it { expect(seventh.previous).to eq sixth }
      end
      context "#following" do
        it { expect(first.following).to eq second }
        it { expect(second.following).to eq third }
        it { expect(third.following).to eq fourth }
        it { expect(fourth.following).to eq fifth }
        it { expect(fifth.following).to eq sixth }
        it { expect(sixth.following).to eq seventh }
        it { expect(seventh.following).to eq nil }
      end
      context "#previous_balance" do
        it { expect(first.reload.previous_balance).to eq 0 }
        it { expect(second.reload.previous_balance).to eq 100 }
        it { expect(third.reload.previous_balance).to eq 300 }
        it { expect(fourth.reload.previous_balance).to eq 600 }
        it { expect(fifth.reload.previous_balance).to eq 1000 }
        it { expect(sixth.reload.previous_balance).to eq 1500 }
        it { expect(seventh.reload.previous_balance).to eq 2100 }
      end
    end
    context "when date doesnt get generated chronologically" do
      let!(:first) { create(:customer_ca_movement, amount: 100, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now - 1.second)}
      let!(:third) { create(:customer_ca_movement, amount: 300, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now)}
      let!(:fourth) {  create(:customer_ca_movement, amount: 400, customer_ca_movement_category_id: 2, customer: customer, date: DateTime.now) }
      let!(:fifth) { create(:customer_ca_movement, amount: 500, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now)}
      let!(:second) { create(:customer_ca_movement, amount: 200, customer_ca_movement_category_id: 1, customer: customer, date: DateTime.now - 1.second)}
      context "#previous" do
        it { expect(first.previous).to eq nil }
        it { expect(second.previous).to eq first }
        it { expect(third.previous).to eq second }
        it { expect(fourth.previous).to eq third }
        it { expect(fifth.previous).to eq fourth }
      end
      context "#following" do
        it { expect(first.following).to eq second }
        it { expect(second.following).to eq third }
        it { expect(third.following).to eq fourth }
        it { expect(fourth.following).to eq fifth }
        it { expect(fifth.following).to eq nil }
      end
      context "#previous_balance" do
        it { expect(first.reload.previous_balance).to eq 0 }
        it { expect(second.reload.previous_balance).to eq 100 }
        it { expect(third.reload.previous_balance).to eq 300 }
        it { expect(fourth.reload.previous_balance).to eq 600 }
        it { expect(fifth.reload.previous_balance).to eq 200 }
      end
    end
  end

  context '#destroy' do
    before {subject}
    let(:customer) { subject.customer }
    context "withour associations" do
      it { expect{ subject.destroy }.to change{ CustomerCaMovement.count }.from(1).to(0) }
      it { expect{ subject.destroy }.to change{ customer.total }.from(10000).to(0) }
    end
    context 'with sale associated' do
      let!(:sale) { create(:sale, sale_details: [build(:sale_detail, unit_price: 100, quantity: 10, iva: 21, sale: nil)])}
      subject(:customer_ca_movement) { sale.customer_ca_movement }
      it_behaves_like 'falsy and error setter'     
    end
  end
  
end
