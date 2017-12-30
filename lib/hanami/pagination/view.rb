require 'hanami/helpers'

module Hanami
  module Pagination
    module View
      include Hanami::Helpers

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

      def paginate(page)
        html.nav(class: 'pagination') do
          content = []

          content << first_page_tag unless pager.first_page?
          content << ellipsis_tag if pager.current_page > 3
          content << previous_page_tag(page) if pager.current_page > 2
          content << current_page_tag
          content << next_page_tag(page) if (pager.total_pages - pager.current_page) > 1
          content << ellipsis_tag if (pager.total_pages - pager.current_page) > 3
          content << last_page_tag unless pager.last_page?

          raw(content.map(&:to_s).join)
        end
      end

      def first_page_tag
        html.a(href: page_url(1), class: 'pagination-first-page') do
          '1'
        end
      end

      def previous_page_tag(page)
        html.a(href: previous_page_path(page), class: 'pagination-previous-page') do
          pager.prev_page
        end
      end

      def current_page_tag
        html.span(class: 'pagination-current-page') do
          pager.current_page
        end
      end

      def last_page_tag
        html.a(href: page_url(pager.total_pages), class: 'pagination-last-page') do
          pager.total_pages
        end
      end

      def next_page_tag(page)
        html.a(href: next_page_path(page), class: 'pagination-next-page') do
          pager.next_page
        end
      end

      def ellipsis_tag
        html.span(class: 'pagination-ellipsis') do
          '...'
        end
      end
    end
  end
end
