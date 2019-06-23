require 'rails_helper'

RSpec.describe ScraperExpression, type: :model do

  describe '#expression' do
    it {
      is_expected.to(
        allow_value("css('#productTitle').first.content.strip").for(:expression)
      )
    }

    it {
      is_expected.to_not(
        allow_value("css('#productTitle').first.content.strip;Product.first.destroy").for(:expression)
      )
    }
  end

end
