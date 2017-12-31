module Hanami
  module Pagination
    class Pager
      attr_reader :pager

      def initialize(pager)
        @pager = pager
      end

      def next_page
        pager.next_page
      end

      def prev_page
        pager.prev_page
      end

      def total
        pager.total
      end

      def total_pages
        pager.total_pages
      end

      def current_page
        pager.current_page
      end

      def current_page?(page)
        pager.current_page == page
      end

      def pages_range(delta: 3)
        first = pager.current_page - delta
        first = first > 0 ? first : 1

        last = pager.current_page + delta
        last = last < pager.total_pages ? last : pager.total_pages

        (first..last).to_a
      end

      def all_pages
        (1..pager.total_pages).to_a
      end

      def first_page?
        pager.current_page == 1
      end

      def last_page?
        pager.current_page == pager.total_pages
      end
    end
  end
end
