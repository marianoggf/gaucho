require 'rails_helper'

module Gaucho
  RSpec.describe Customer, type: :model do
    subject(:customer) { create(:customer, address: nil) }
    it { should respond_to(:name) }
    it { should respond_to(:cuit) }
    it { should respond_to(:address) }
    it { should be_valid }
    its(:name) {should be_present}
    its(:cuit) {should be_present}
    its(:address) {should be_nil}
  end
end
