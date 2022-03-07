require 'rails_helper'

RSpec.describe 'Book Service' do
  it 'returns a faraday response', :vcr do
      connection = BookService.connection
      expect(connection).to be_a(Faraday::Connection)
  end

  it 'returns forecast data form longitude and latitude', :vcr do
    origin = 'denver,co'

    books = BookService.get_books(origin)
    expect(books).to be_a(Hash)
    expect(books).to have_key(:numFound)
    expect(books).to have_key(:docs)
    expect(books[:docs][0]).to have_key(:isbn)
    expect(books[:docs][0]).to have_key(:title)
    expect(books[:docs][0]).to have_key(:publisher)
  end
end
