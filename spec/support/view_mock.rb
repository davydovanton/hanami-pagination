class ViewMock
  attr_reader :pager

  def initialize(current_page = 1, total_pages = 10)
    @pager = PagerMock.new(current_page, total_pages)
  end
end
