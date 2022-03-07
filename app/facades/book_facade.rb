class BookFacade
  def self.find_books(location)
    json = BookService.get_books(location)
  end
end
