require 'rails_helper'

describe ReceiptType, type: :model do
   

  subject { ReceiptType.first } 
  it { should respond_to(:name) }
  it { should have_many(:receipts)}
  
  its(:destroy) { should eq false }

end
