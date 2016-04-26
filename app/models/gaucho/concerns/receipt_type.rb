module Gaucho::Concerns::ReceiptType
  extend ActiveSupport::Concern

  included do
    has_many :receipts
  end



end