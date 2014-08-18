class LandingsController < ApplicationController
  def show
    @keywords = {
      "author>" => "your name",
      "bio>" => "context in which you exist",
      "twitter>" => "twitter handle",
      "github>" => "github username",
      "blog>" => "http://your-blog.com",
      "description>" => "context in which this package exists",
      "link>" => "Link 1 Name | http://link-1.net",
      "slug>" => "'your-package-name' of your-package-name@pkg.cat. All letters
      will be downcase. Spaces and special characters will become hyphens."
  }
  end
end
