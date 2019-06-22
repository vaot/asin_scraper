require 'rails_helper'

RSpec.describe AsinScraperService do

  describe '#fetch' do
    let!(:asin) do
      entries = Dir.entries(Rails.root.join("spec", "examples", "amazon_pages"))
      entries = entries.select { |file| !['.', '..'].include?(file) }
      entries.sample
    end

    context 'With a valid page' do
      before :each do
        allow_any_instance_of(described_class).to receive(:get_html).and_return(
          File.read(Rails.root.join("spec", "examples", "amazon_pages", asin))
        )

        normalized_asin = asin.gsub(".html", "")
        described_class.new(normalized_asin).fetch
        @product = Product.where(asin: normalized_asin).first
      end

      it 'should have title' do
        expect(@product.title.present?).to eq(true)
      end

      it 'should have amazon_image_url' do
        expect(@product.amazon_image_url.present?).to eq(true)
      end

      it 'should have length_in_hundreds' do
        expect(@product.length_in_hundreds.present?).to eq(true)
      end

      it 'should have width_in_hundreds' do
        expect(@product.width_in_hundreds.present?).to eq(true)
      end

      it 'should have height_in_hundreds' do
        expect(@product.height_in_hundreds.present?).to eq(true)
      end

      it 'should have best_seller_rank' do
        expect(@product.best_seller_rank.present?).to eq(true)
      end

      it 'should have category' do
        expect(@product.category.present?).to eq(true)
      end

      it 'should have active status' do
        expect(@product.status).to eq("active")
      end
    end

    context 'With an invalid page' do
      before :each do
        allow_any_instance_of(described_class).to receive(:get_html).and_return(
          "<html><head</head><body></body></html>"
        )

        normalized_asin = asin.gsub(".html", "")
        described_class.new(normalized_asin).fetch
        @product = Product.where(asin: normalized_asin).first
      end

      it 'should not have title' do
        expect(@product.title.present?).to eq(false)
      end

      it 'should not have amazon_image_url' do
        expect(@product.amazon_image_url.present?).to eq(false)
      end

      it 'should not have length_in_hundreds' do
        expect(@product.length_in_hundreds.zero?).to eq(true)
      end

      it 'should not have width_in_hundreds' do
        expect(@product.width_in_hundreds.zero?).to eq(true)
      end

      it 'should not have height_in_hundreds' do
        expect(@product.height_in_hundreds.zero?).to eq(true)
      end

      it 'should not have best_seller_rank' do
        expect(@product.best_seller_rank.present?).to eq(false)
      end

      it 'should not have category' do
        expect(@product.category.present?).to eq(false)
      end

      it 'should have inactive status' do
        expect(@product.status).to eq("inactive")
      end
    end
  end

  describe '#to_url' do
    let(:asin) { "myasin" }
    let(:service) { described_class.new(asin) }

    context 'With asin number' do
      it 'should construct proper url' do
        expect(service.send(:to_url)).to eq("https://www.amazon.com/dp/myasin")
      end
    end
  end

end
