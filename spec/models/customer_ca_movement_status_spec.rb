require 'rails_helper'

describe CustomerCaMovementStatus, type: :model do
  
  it { should have_db_column(:code).of_type(:integer).with_options(null: false, unique: true) }
  it { should have_db_column(:name).of_type(:string).with_options(null: false, unique: true) }
  it { should have_many :customer_ca_movements }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:code) }


end
