RSpec.describe Hanami::Pagination::Pager do
  let(:mock_pager) { Hanami::Pagination::MockPager.new(current_page, total_pages) }
  let(:current_page) { 1 }
  let(:total_pages) { 10 }

  let(:pager) { Hanami::Pagination::Pager.new(mock_pager) }

  describe '#pager' do
    it { expect(pager.pager).to be_a Hanami::Pagination::MockPager }
  end

  describe '#next_page' do
    it { expect(pager.next_page).to eq 2 }

    context 'on other page' do
      let(:current_page) { 10 }
      it { expect(pager.next_page).to eq 10 }
    end
  end

  describe '#prev_page' do
    it { expect(pager.prev_page).to eq 1 }

    context 'on other page' do
      let(:current_page) { 3 }
      it { expect(pager.prev_page).to eq 2 }
    end
  end

  describe '#total' do
    it { expect(pager.total).to eq 10 }
  end

  describe '#total_pages' do
    it { expect(pager.total_pages).to eq 10 }
  end

  describe '#current_page' do
    it { expect(pager.current_page).to eq 1 }
  end

  describe '#current_page?' do
    it { expect(pager.current_page?(1)).to eq true }
    it { expect(pager.current_page?(2)).to eq false }
  end

  describe '#pages_range' do
    it { expect(pager.pages_range).to eq (1..4).to_a }
    it { expect(pager.pages_range(delta: 1)).to eq [1, 2] }

    context 'on other page' do
      let(:current_page) { 5 }
      it { expect(pager.pages_range).to eq (2..8).to_a }
      it { expect(pager.pages_range(delta: 1)).to eq [4, 5, 6] }
    end
  end

  describe '#all_pages' do
    it { expect(pager.all_pages).to eq (1..10).to_a }
  end

  describe '#first_page?' do
    it { expect(pager.first_page?).to eq true }

    context 'on other page' do
      let(:current_page) { 5 }
      it { expect(pager.first_page?).to eq false }
    end

    context 'on other page' do
      let(:current_page) { 10 }
      it { expect(pager.first_page?).to eq false }
    end
  end

  describe '#last_page?' do
    it { expect(pager.last_page?).to eq false }

    context 'on other page' do
      let(:current_page) { 5 }
      it { expect(pager.last_page?).to eq false }
    end

    context 'on other page' do
      let(:current_page) { 10 }
      it { expect(pager.last_page?).to eq true }
    end

    context 'with zero elements' do
      let(:current_page) { 1 }
      let(:total_pages) { 0 }

      it { expect(pager.last_page?).to eq true }
    end
  end
end
