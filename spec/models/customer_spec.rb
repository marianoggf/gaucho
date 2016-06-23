require 'rails_helper'

describe Customer, type: :model do
    
  subject(:customer) { create(:customer) }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:cuit).of_type(:string) }
  it { should have_db_column(:address).of_type(:string) }
  it { should have_many(:customer_ca_movements)}
  it { should have_many(:sales)}
  it { should belong_to :customer_category }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:cuit).allow_blank }


  context '#total' do
    let(:movement_1) { create(:customer_ca_movement, amount: 1000, customer: customer, customer_ca_movement_category_id: 1)}
    let(:movement_2) { create(:customer_ca_movement, amount: 2000, customer: customer, customer_ca_movement_category_id: 2)}
    let(:two_movements) do
      movement_1
      movement_2
    end
    it { expect(customer.total).to eq(0) }
    it { expect{movement_1}.to change{ customer.total }.from(0).to(1000)}
    it { expect{two_movements}.to change{ customer.total }.from(0).to(-1000)}
  end

  context "#destroy" do
    context 'without associations' do
      subject { create(:customer) }
      it_behaves_like 'self returner when destroyed'
    end
    context 'with associated sales' do
      let(:sale) { create(:sale) }
      subject { sale.customer }
      it_behaves_like 'falsy and error setter'
    end
    context 'with associated customer_ca_movements' do
      let(:customer_ca_movement) { create(:customer_ca_movement, customer_ca_movement_category_id: 1)}
      subject { customer_ca_movement.customer }
      it_behaves_like 'falsy and error setter'
    end
  end
end
