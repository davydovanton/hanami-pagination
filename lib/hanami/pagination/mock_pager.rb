module Hanami
  module Pagination
    class MockPager
      attr_reader :current_page, :total_pages

      def initialize(current_page, total_pages)
        @current_page = current_page
        @total_pages = total_pages
      end

      def next_page
        [current_page + 1, total_pages].min
      end

      def prev_page
        [current_page - 1, 1].max
      end

      def total
        total_pages
      end

      def total_pages
        @total_pages
      end
    end
  end
end
