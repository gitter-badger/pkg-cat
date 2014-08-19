class PackagesController < ApplicationController
  MAX_AMOUNT_OF_LINKS = 5

  def new
    @package = Package.new
    number_of_links_left.times do
      @package.links.build
    end
  end

  def create
    @package = Package.new(package_params)
    @package.private_token = SecureRandom.urlsafe_base64(64)

    if @package.save
      @package.attach(params[:package][:file])
      OutboundMailer.confirmation(@package).deliver
      flash[:success] = "Package Created Successfully!"
      redirect_to [:edit, @package]
    else
      render :new
    end
  end

  def edit
    @package = Package.find_by!(private_token: private_token)
    number_of_links_left.times do
      @package.links.build
    end
  end

  def update
    package = Package.find_by!(private_token: private_token)
    package.update(package_params)
    if package.slug != proposed_slug
      flash[:alert] = "#{proposed_slug} is taken. Please try again"
    end
    package.attach(params[:package][:file])

    redirect_to [:edit, package]
  end

  def destroy
    package = Package.find_by!(private_token: private_token)
    package.destroy
    flash[:success] = "Package destroyed successfully."
    redirect_to root_path
  end

  private

  def package_params
    params.require(:package).permit(
      :email,
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

  def private_token
    params[:id]
  end

  def proposed_slug
    params[:package][:slug].parameterize
  end
end
