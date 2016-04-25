require 'rails_helper'

describe Customer, type: :model do
    
  subject(:customer) { create(:customer) }
  it { should respond_to(:name) }
  it { should respond_to(:cuit) }
  it { should respond_to(:address) }
  it { should have_many(:customer_ca_movements)}
  it { should have_many(:sales)}
  it { should belong_to :customer_type }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  context "#destroy" do
    context 'without associations' do
      subject { create(:customer) }
      it_behaves_like 'self returner when destroyed'
    end
    context 'with associated sales' do
      let(:sale) { create(:sale) }
      subject { sale.customer }
      it_behaves_like 'falsy and error setter', "No se puede eliminar porque está asociado a una o varias ventas."
    end
    context 'with associated customer_ca_movements' do
      let(:customer_ca_movement) { create(:customer_ca_movement, customer_ca_movement_type_id: 1)}
      subject { customer_ca_movement.customer }
      it_behaves_like 'falsy and error setter', "No se puede eliminar porque está asociado a uno o varios movimientos de cuenta corriente."
    end
  end
end
