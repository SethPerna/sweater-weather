class BackgroundSerializer
  def self.image(background, location)
    { "data":
      {
        "id": nil,
        "type": 'image',
        "attributes":
        {
          "image":
          {
            "location": location,
            "image_url": background[:photos][0][:url]
          },
          "credit":
          {
            "source": background[:photos][0][:photographer_url],
            "author": background[:photos][0][:photographer],
            "logo": background[:photos][0][:src][:small]
          }
        }
      }
    }
  end
end
