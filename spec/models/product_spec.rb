require 'rails_helper'

RSpec.describe Product, type: :model do

  describe '#asin' do
    it { is_expected.to validate_presence_of(:asin) }
    it { is_expected.to validate_uniqueness_of(:asin) }
  end

end
