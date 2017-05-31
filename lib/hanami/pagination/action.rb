module Hanami
  module Pagination
    module Action
      def self.included(action)
        action.class_eval do
          expose :pager
        end
      end

      def all_for_page(relation)
        relation = relation.per_page(limit).page(params[:page] || 1)
        @pager = Pager.new(relation.pager)
        relation.to_a
      end

      def limit
        100
      end
    end
  end
end
