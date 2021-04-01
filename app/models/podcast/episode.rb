# frozen_string_literal: true

require 'fileutils'

class Podcast::Episode < ApplicationRecord
  EPISODE_ATTRIBUTES = %i[title season number description published_at image explicit].freeze

  belongs_to :podcast
  has_many :highlights, class_name: 'Podcast::Highlight'

  uploader :file, :file, extensions: %i[ogg mp3 wav]

  aasm :montage, column: :montage_state do
    state :recording, initial: true
    state :recorded
    state :montaged

    event :montage, before: :cut_highlights do
      transitions from: :recording, to: :montaged
      transitions from: :recorded, to: :montaged
    end
  end

  def cut_highlights
    filename = convert_file

    directory = prepare_directory

    highlights.each_with_index do |highlight, index|
      hour = highlight.time.split(':')[0]
      minutes = highlight.time.split(':')[1]
      seconds = highlight.time.split(':')[2]
      highlight_time = DateTime.new(2020, 0o1, 0o1, hour.to_i, minutes.to_i, seconds.to_i)
      begin_time = (highlight_time - 2.minutes).strftime '%H:%M:%S'
      end_time = (highlight_time + 10.seconds).strftime '%H:%M:%S'
      system "ffmpeg -y -i #{filename} -ss #{begin_time} -to #{end_time} -c copy #{directory}/part-#{index + 1}.mp3"
    end
  end

  private

  def convert_file
    filename = file.path.split('.')[0..-2].join('.')

    if file.path.split('.').last == 'ogg'
      filename += '.mp3'
      system "ffmpeg -y -i #{file.path} #{filename}"
    end

    filename
  end

  def prepare_directory
    podcasts_directory = "#{Rails.root}/public/podcasts/"
    FileUtils.mkdir_p podcasts_directory

    current_podcast_directory = "#{Rails.root}/public/podcasts/#{podcast.title.gsub(' ', '_')}/"
    FileUtils.mkdir_p current_podcast_directory
    "#{Rails.root}/public/podcasts/#{podcast.title.gsub(' ', '_')}/#{number}/".tap do |dir|
      FileUtils.mkdir_p dir
    end
  end
end
