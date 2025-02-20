# frozen_string_literal: true

require 'colorize'

Bot.active.find_each do |bot|
  BotJob.perform_later bot.id, bot.name
  puts "#{bot.name} started".green
end
