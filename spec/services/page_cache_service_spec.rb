require 'rails_helper'

RSpec.describe PageCacheService do
  describe '#fetch' do
    let(:asin) { "0123456789" }
    let(:service) { described_class.new(asin) }
    let(:page) { "<html></html>" }

    context 'Cached' do
      before :each do
        PageCacheService.new(asin).fetch do
          page
        end
      end

      it 'should have the result cached' do
        expect(service.cached?).to eq(true)
      end

      it 'should retrieve the result' do
        expect(service.fetch { page }).to eq(page)
      end
    end

    context 'Not cached' do
      it 'should cache the result' do
        service.fetch { page }
        expect(service.cached?).to eq(true)
      end

      it 'should retrieve the result' do
        expect(service.fetch).to eq(page)
      end
    end
  end
end
