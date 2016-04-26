module Gaucho::Concerns::ReceiptType
  extend ActiveSupport::Concern
  include Gaucho::Concerns::Indestructible

  included do
    has_many :receipts
  end



end