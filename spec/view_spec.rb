module View
  class Index < ViewMock
    include Hanami::Pagination::View

    def params
      Params.new
    end

    def routes
      Routes.new
    end

    class Params
      attr_reader :params, :env

      def env
       { 'REQUEST_PATH' => '/books' }
      end

      def to_h
        params
      end
      alias_method :to_hash, :to_h

      def each(&blk)
        to_h.each(&blk)
      end

      def params
        { country: 'rus' }
      end
    end

    class Routes
      def path(route, *params)
        result = "/#{route}"
        query_string = params.first.each.map { |k, v| "#{k}=#{v}" }.join '&'
        result = "#{result}?#{query_string}" unless query_string.empty?
        result
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

  describe '#previous_page_path' do
    it { expect(view.previous_page_path(:books)).to eq '/books?country=rus&page=1' }
  end

  describe '#next_page_path' do
    it { expect(view.next_page_path(:resources)).to eq '/resources?country=rus&page=2' }
  end

  describe '#n_page_path' do
    it { expect(view.n_page_path(:users, 7)).to eq '/users?country=rus&page=7' }
  end
end