class BooksSerializer
  def self.book_response(forecast, books, location, quantity)
    hash = {
      "data":
      {
        "id": nil,
        "type": "books",
        "attributes":
        {
          "destination": "#{location}",
          "forecast":
          {
            "summary": forecast[:current][:weather][0][:description],
            "temperature": forecast[:current][:temp]
          },
          "total_books_found": books[:numFound],
          "books": books[:docs].shift(quantity).map do |book|
            {
              "isbn": book[:isbn],
              "title": book[:title],
              "publisher": book[:publisher],
            }
          end
        }
      }
    }
  end
end
