class PackagesController < ApplicationController
  def edit
    @package = Package.find(params[:id])
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
         :url
      ]
    )
  end
end
