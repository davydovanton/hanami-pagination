module Hanami
  module Pagination
    module View
      def next_page_url
        page_url(pager.next_page)
      end

      def prev_page_url
        page_url(pager.prev_page)
      end

      def page_url(page)
        "#{params.env['REQUEST_PATH']}?page=#{page}"
      end

      def previous_page_path(page)
        routes.path(page, **params, page: pager.prev_page)
      end

      def next_page_path(page)
        routes.path(page, **params, page: pager.next_page)
      end

      def n_page_path(page, n)
        routes.path(page, **params, page: n)
      end
    end
  end
end