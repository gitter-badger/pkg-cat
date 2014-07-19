class LandingsController < ApplicationController
  def show
    @keywords = {
      "author>" => "your name",
      "bio>" => "context in which you exist",
      "twitter>" => "twitter handle",
      "github>" => "github username",
      "blog>" => "http://your-blog.com",
      "description>" => "context in which this package exists",
      "link>" => "Link 1 Name::http://link-1.net"
  }
  end
end
