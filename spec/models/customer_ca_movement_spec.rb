require 'rails_helper'

describe CustomerCaMovement, type: :model do

  subject { create :customer_ca_movement, amount: 10000  }
  let(:now) { DateTime.now }
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

  context 'when creating a movement' do
    subject { create :customer_ca_movement, customer_ca_movement_status_id: 2 }
    its(:customer_ca_movement_status_id) { should eq 1  }
  end

  context 'when changing customer_ca_movement_status_id to other than 1' do
    subject { create :customer_ca_movement }
    before { subject.update customer_ca_movement_status_id: 2 }
    its(:customer_ca_movement_status_id) { should eq 2  }
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
      let!(:canceled_movement_1) { create :canceled_customer_ca_movement, customer: customer, date: now + 3.second }
      let!(:canceled_movement_2) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:first) { create(:customer_ca_movement, amount: 100, customer: customer, date: now - 1.second)}
      let!(:canceled_movement_3) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:canceled_movement_4) { create :canceled_customer_ca_movement, customer: customer, date: now + 2.second }
      let!(:canceled_movement_5) { create :canceled_customer_ca_movement, customer: customer, date: now + 0.second }
      let!(:second) { create(:customer_ca_movement, amount: 200, customer: customer, date: now - 1.second)}
      let!(:canceled_movement_6) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:third) { create(:customer_ca_movement, amount: 300, customer: customer, date: now)}
      let!(:canceled_movement_7) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:fourth) {  create(:customer_ca_movement, amount: 400, customer: customer, date: now) }
      let!(:canceled_movement_8) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:fifth) { create(:customer_ca_movement, amount: 500, customer: customer, date: now)}
      let!(:canceled_movement_9) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:sixth) { create(:customer_ca_movement, amount: 600, customer: customer, date: now + 1.second)}
      let!(:canceled_movement_) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:seventh) { create(:customer_ca_movement, amount: 700, customer: customer, date: now + 1.second)}
      let!(:canceled_movement_10) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:canceled_movement_11) { create :canceled_customer_ca_movement, customer: customer, date: now + 3.second }
      let!(:canceled_movement_12) { create :canceled_customer_ca_movement, customer: customer, date: now - 1.second }
      let!(:from_another_customer) { create(:customer_ca_movement, amount: 100, customer: create(:customer), date: now + 4.second)}
      let!(:eighth) { create(:customer_ca_movement, amount: 800, customer: customer, date: now + 4.second)}
      let!(:from_another_customer) { create(:customer_ca_movement, amount: 100, customer: create(:customer), date: now + 4.second)}
      let!(:canceled_movement_13) { create :canceled_customer_ca_movement, customer: customer, date: now }
      context "#previous" do
        it { expect(first.previous).to eq nil }
        it { expect(second.previous).to eq first }
        it { expect(third.previous).to eq second }
        it { expect(fourth.previous).to eq third }
        it { expect(fifth.previous).to eq fourth }
        it { expect(sixth.previous).to eq fifth }
        it { expect(seventh.previous).to eq sixth }
        it { expect(eighth.previous).to eq seventh }
      end
      context "#following" do
        it { expect(first.following).to eq second }
        it { expect(second.following).to eq third }
        it { expect(third.following).to eq fourth }
        it { expect(fourth.following).to eq fifth }
        it { expect(fifth.following).to eq sixth }
        it { expect(sixth.following).to eq seventh }
        it { expect(seventh.following).to eq eighth }
        it { expect(eighth.following).to eq nil }
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
