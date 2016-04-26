require 'rails_helper'

describe ReceiptCategory, type: :model do
    
  it { should respond_to(:name) }
  it { should have_many(:receipts)}
  
end
