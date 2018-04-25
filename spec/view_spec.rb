module View
  class Index < ViewMock
    include Hanami::Pagination::View

    def initialize(*args)
      super
      @params_page = args[0]
    end

    def params
      Params.new(params_page)
    end

    def routes
      Routes.new
    end

    class Params
      attr_reader :params, :env

      def initialize(params_page)
        @params_page = params_page
      end

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
        if params_page.nil?
          { country: 'rus' }
        else
          { country: 'rus', page: params_page.to_s }
        end
      end

      private

      attr_reader :params_page
    end

    class Routes
      def path(route, *params)
        result = "/#{route}"
        query_string = params.first.each.map { |k, v| "#{k}=#{v}" }.join '&'
        result = "#{result}?#{query_string}" unless query_string.empty?
        result
      end
    end

    private

    attr_reader :params_page
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

  describe 'html' do
    describe '#paginate' do
      let(:html) { view.paginate(:books).to_s }

      it 'with <nav class="pagination"> tag' do
        expect(html).to include('<nav class="pagination">')
        expect(html).to include('</nav>')
      end

      context 'when page is 1/10' do
        it { expect(html).not_to include 'pagination-first-page' }
        it { expect(html).not_to include 'pagination-previous-page' }
        it { expect(html).to include 'pagination-current-page' }
        it { expect(html).to include 'pagination-next-page' }
        it { expect(html).to include 'pagination-last-page' }
        it { expect(html.scan('pagination-ellipsis').count).to eql 1 }
      end

      context 'when page is 5/10' do
        let(:view) { View::Index.new(5) }
        let(:html) { view.paginate(:books).to_s }

        it { expect(html).to include 'pagination-first-page' }
        it { expect(html).to include 'pagination-previous-page' }
        it { expect(html).to include 'pagination-current-page' }
        it { expect(html).to include 'pagination-next-page' }
        it { expect(html).to include 'pagination-last-page' }
        it { expect(html.scan('pagination-ellipsis').count).to eql 2 }
      end

      context 'when page is 10/10' do
        let(:view) { View::Index.new(10) }
        let(:html) { view.paginate(:books).to_s }


        it { expect(html).to include 'pagination-first-page' }
        it { expect(html).to include 'pagination-previous-page' }
        it { expect(html).to include 'pagination-current-page' }
        it { expect(html).not_to include 'pagination-next-page' }
        it { expect(html).not_to include 'pagination-last-page' }
        it { expect(html.scan('pagination-ellipsis').count).to eql 1 }
      end
    end

    describe '#first_page_tag' do
      let(:html) { view.first_page_tag.to_s }

      it { expect(html).to include '<a ' }
      it { expect(html).to include 'href="/books?page=1"' }
      it { expect(html).to include 'class="pagination-first-page"' }
      it { expect(html).to include '1' }
      it { expect(html).to include '</a>' }
    end

    describe '#previous_page_tag' do
      let(:html) { view.previous_page_tag(:books).to_s }

      it { expect(html).to include '<a ' }
      it { expect(html).to include 'href="/books?country=rus&page=1"' }
      it { expect(html).to include 'class="pagination-previous-page"' }
      it { expect(html).to include '1' }
      it { expect(html).to include '</a>' }
    end

    describe '#current_page_tag' do
      let(:html) { view.current_page_tag.to_s }

      it { expect(html).to include '<span ' }
      it { expect(html).to include 'class="pagination-current-page"' }
      it { expect(html).to include '1' }
      it { expect(html).to include '</span>' }
    end

    describe '#last_page_tag' do
      let(:html) { view.last_page_tag.to_s }

      it { expect(html).to include '<a ' }
      it { expect(html).to include 'href="/books?page=10"' }
      it { expect(html).to include 'class="pagination-last-page"' }
      it { expect(html).to include '10' }
      it { expect(html).to include '</a>' }
    end

    describe '#next_page_tag' do
      let(:html) { view.next_page_tag(:books).to_s }

      it { expect(html).to include '<a ' }
      it { expect(html).to include 'href="/books?country=rus&page=2"' }
      it { expect(html).to include 'class="pagination-next-page"' }
      it { expect(html).to include '2' }
      it { expect(html).to include '</a>' }
    end

    describe '#ellipsis_tag' do
      let(:html) { view.ellipsis_tag.to_s }

      it { expect(html).to include '<span ' }
      it { expect(html).to include 'class="pagination-ellipsis"' }
      it { expect(html).to include '...' }
      it { expect(html).to include '</span>' }
    end
  end
end
