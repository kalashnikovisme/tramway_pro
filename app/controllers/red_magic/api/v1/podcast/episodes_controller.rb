# frozen_string_literal: true

class RedMagic::Api::V1::Podcast::EpisodesController < RedMagic::Api::V1::Podcast::Episodes::ApplicationController
  def update
    #::PodcastsMontageJob.perform_later params[:id]
    #::PodcastsHighlightsJob.perform_later params[:id]

    episode = Podcast::Episode.find params[:id]
    episode.send params[:process]

    redirect_to ::Tramway::Admin::Engine.routes.url_helpers.record_path(params[:id], model: Podcast::Episode)
  end
end
