# frozen_string_literal: true

#Tramway::Core.initialize_application model_class: PurpleMagic

Tramway::Admin.set_singleton_models PurpleMagic, project: :purple_magic

Tramway::Admin.set_available_models(
  Tramway::Landing::Block,
  Tramway::Page::Page,
  Tramway::User::User,
  ChatQuestUlsk::Message,
  ChatQuestUlsk::Game,
  ChatQuestUlsk::Chapter,
  BotTelegram::User,
  BotTelegram::Message,
  BotTelegram::Scenario::Step,
  BotTelegram::Scenario::ProgressRecord,
  project: :purple_magic
)

Tramway::Admin.set_available_models(
  ChatQuestUlsk::Message,
  ChatQuestUlsk::Game,
  ChatQuestUlsk::Chapter,
  BotTelegram::User,
  BotTelegram::Message,
  role: :partner,
  project: :purple_magic
)

Tramway::Admin.navbar_structure(
  PurpleMagic,
  {
    landing: [
      Tramway::Page::Page,
      Tramway::Landing::Block
    ]
  },
  {
    chat_quest_ulsk: [
      BotTelegram::User,
      ChatQuestUlsk::Message,
      ChatQuestUlsk::Game,
      ChatQuestUlsk::Chapter,
      BotTelegram::Message
    ]
  },
  {
    rsm_project_office_bot: [
      BotTelegram::User,
      BotTelegram::Scenario::Step,
      BotTelegram::Scenario::ProgressRecord,
    ]
  },
  Tramway::User::User,
  project: :purple_magic
)
