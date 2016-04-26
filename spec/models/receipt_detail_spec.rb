require 'rails_helper'

describe ReceiptDetail, type: :model do
    
  it { should have_db_column(:description).of_type(:string) }
  it { should have_db_column(:quantity).of_type(:decimal) }
  it { should have_db_column(:unit_price).of_type(:decimal) }
  it { should have_db_column(:iva).of_type(:decimal) }
  it { should belong_to :receipt }


end