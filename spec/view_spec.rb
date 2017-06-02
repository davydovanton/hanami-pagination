module View
  class Index < ViewMock
    include Hanami::Pagination::View

    def params
      Env.new
    end

    class Env
      def env
        { 'REQUEST_PATH' => '/books' }
      end
    end
  end
end

RSpec.describe Hanami::Pagination::View do
  let(:view) { View::Index.new }

  describe '#next_page_url' do
    it { expect(view.next_page_url).to eq '/books?page=2' }
  end

  describe '#prev_page_url' do
    it { expect(view.prev_page_url).to eq '/books?page=1' }
  end

  describe '#page_url' do
    it { expect(view.page_url(1)).to eq '/books?page=1' }
    it { expect(view.page_url(5)).to eq '/books?page=5' }
    it { expect(view.page_url(10)).to eq '/books?page=10' }
  end
end
