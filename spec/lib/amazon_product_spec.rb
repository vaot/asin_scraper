require 'rails_helper'

RSpec.describe AmazonProduct do

  let(:asin) do
    entries = Dir.entries(Rails.root.join("spec", "examples", "amazon_pages"))
    entries = entries.select { |file| !['.', '..'].include?(file) }
    entries.sample
  end

  let(:doc) do
    Nokogiri::HTML(
      File.read(Rails.root.join("spec", "examples", "amazon_pages", asin))
    )
  end

  let(:invalid_doc) { Nokogiri::HTML("<html><head</head><body></body></html>") }

  describe '#title' do
    context 'With a valid title' do
      let(:presenter) { described_class.new(doc) }

      it 'should have a title' do
        expect(presenter.title.present?).to eq(true)
      end
    end

    context 'With an invalid title' do
      let(:presenter) { described_class.new(invalid_doc) }

      it 'should swallow exceptions and return nil' do
        expect(presenter.title).to eq(nil)
      end
    end
  end

  describe '#image_url' do
    context 'With a valid image_url' do
      let(:presenter) { described_class.new(doc) }

      it 'should have an image_url' do
        expect(presenter.image_url.present?).to eq(true)
      end
    end

    context 'With an invalid image_url' do
      let(:presenter) { described_class.new(invalid_doc) }

      it 'should swallow exceptions and return nil' do
        expect(presenter.image_url).to eq(nil)
      end
    end
  end

  describe '#category' do
    context 'With a valid category' do
      let(:presenter) { described_class.new(doc) }

      it 'should have a category' do
        expect(presenter.category.present?).to eq(true)
      end
    end

    context 'With an invalid category' do
      let(:presenter) { described_class.new(invalid_doc) }

      it 'should swallow exceptions and return nil' do
        expect(presenter.category).to eq(nil)
      end
    end
  end

  describe '#best_seller_rank' do
    context 'With a valid best_seller_rank' do
      let(:presenter) { described_class.new(doc) }

      it 'should have a best_seller_rank' do
        expect(presenter.best_seller_rank.present?).to eq(true)
      end
    end

    context 'With an invalid best_seller_rank' do
      let(:presenter) { described_class.new(invalid_doc) }

      it 'should swallow exceptions and return nil' do
        expect(presenter.best_seller_rank).to eq(nil)
      end
    end
  end

  describe '#dimensions' do
    context 'With a valid dimensions' do
      let(:presenter) { described_class.new(doc) }

      it 'should have dimensions' do
        expect(presenter.dimensions.present?).to eq(!asin.include?("nodimensions"))
      end
    end

    context 'With an invalid dimensions' do
      let(:presenter) { described_class.new(invalid_doc) }

      it 'should swallow exceptions and return empty hash' do
        expect(presenter.dimensions).to eq({})
      end
    end
  end

end
