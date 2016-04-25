require 'rails_helper'

describe CustomerType, type: :model do
    
  subject(:customer_type) { create(:customer_type) }
  it { should respond_to(:name) }
  it { should have_many(:customers)}
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  context "#destroy" do
    context 'with associated customers' do
      let(:customer) { create(:customer) }
      subject { customer.customer_type }
      it_behaves_like 'falsy and error setter', "No se puede eliminar porque está asociado a una o varios clientes."
    end
  end
end
