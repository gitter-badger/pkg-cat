class PackagesController < ApplicationController
  MAX_AMOUNT_OF_LINKS = 5

  def edit
    @package = Package.find(params[:id])
    number_of_links_left.times do
      @package.links.build
    end
  end

  def update
    package = Package.find(params[:id])
    package.update(package_params)

    redirect_to [:edit, package]
  end

  private

  def package_params
    params.require(:package).permit(
      :subject,
      :author,
      :bio,
      :github,
      :twitter,
      :blog,
      :description,
      links_attributes: [
         :id,
         :name,
         :url,
         :_destroy
      ]
    )
  end

  def number_of_links_left
    MAX_AMOUNT_OF_LINKS - @package.links.count
  end
end
