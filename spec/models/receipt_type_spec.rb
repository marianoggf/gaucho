require 'rails_helper'

describe ReceiptType, type: :model do
    
  it { should respond_to(:name) }
  it { should have_many(:receipts)}
  
end
