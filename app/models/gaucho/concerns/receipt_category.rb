module Gaucho::Concerns::ReceiptCategory
  extend ActiveSupport::Concern
  include Gaucho::Concerns::Indestructible
  
  included do
    has_many :receipts
  end

end