# frozen_string_literal: true

class Admin::PodcastForm < Tramway::Core::ApplicationForm
  properties :title, :feed_url, :default_image, :podcast_type

  def initialize(object)
    super(object).tap do
      form_properties title: :string,
        feed_url: :string,
        default_image: :file,
        podcast_type: :default
    end
  end
end
