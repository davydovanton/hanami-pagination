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
    end
  end
end
