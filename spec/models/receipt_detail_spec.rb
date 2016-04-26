require 'rails_helper'

describe ReceiptDetail, type: :model do
    
  it { should have_db_column(:description).of_type(:string) }
  it { should have_db_column(:quantity).of_type(:decimal) }
  it { should have_db_column(:unit_price).of_type(:decimal) }
  it { should have_db_column(:iva).of_type(:decimal) }
  it { should belong_to :receipt }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:iva) }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:iva).is_greater_than_or_equal_to(0) }

end