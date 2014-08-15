class PackagesController < ApplicationController
  MAX_AMOUNT_OF_LINKS = 5

  def edit
    @package = Package.find_by!(token: token)
    number_of_links_left.times do
      @package.links.build
    end
  end

  def update
    package = Package.find_by!(token: token)
    package.update(package_params)
    if package.slug != proposed_slug
      flash[:alert] = "#{proposed_slug} is taken. Please try again"
    end
    package.attach(params[:package][:file])

    redirect_to [:edit, package]
  end

  private

  def package_params
    params.require(:package).permit(
      :slug,
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
      ],
      attachments_attributes: [
        :id,
        :file_file_name,
        :_destroy
      ]
    )
  end

  def number_of_links_left
    MAX_AMOUNT_OF_LINKS - @package.links.count
  end

  def token
    params[:id]
  end

  def proposed_slug
    params[:package][:slug].parameterize
  end
end
