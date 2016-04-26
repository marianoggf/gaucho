module Gaucho::Concerns::ReceiptCategory
  extend ActiveSupport::Concern

  included do
    has_many :receipts
  end

end