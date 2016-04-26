module Gaucho::Concerns::ReceiptDetail
  extend ActiveSupport::Concern

  included do
    belongs_to :receipt
  end

end