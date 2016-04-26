require 'rails_helper'

describe Receipt, type: :model do
    
  subject { create(:receipt, receipt_details: [build(:receipt_detail, receipt: nil), build(:receipt_detail, receipt: nil)]) }
  it { should respond_to :number }
  it { should have_many(:receipt_details).dependent(:destroy)}
  it { should belong_to :receipt_type }
  it { should belong_to :receipt_category }
  it { should belong_to :customer }
  it { should validate_presence_of :number }
  it { should validate_presence_of :receipt_type }
  it { should validate_presence_of :receipt_category }
  it { should validate_presence_of :customer }
  it { should validate_uniqueness_of(:number) }
  it { should accept_nested_attributes_for(:receipt_details).allow_destroy(true) }

  context '#total' do
    its(:total) { should eq 242 }
  end

end
