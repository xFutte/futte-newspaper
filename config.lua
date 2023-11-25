Config = {}

Config.BuyNewspaperText = 'Buy Newspaper' -- Text shown with qb-target
Config.BuyNewspaperIcon = 'fas fa-newspaper' -- Icon shown with qb-target
Config.Price = 100 -- Price of buying the newspaper
Config.AmountOfNews = 10 -- Amount of news to be fetched from the database
Config.AmountOfSentences = 10 -- Amount of prison sentences to be fetched from the database

Config.Items = {
    NEWSPAPER = 'newspaper', -- Item name for the newspaper
}

Config.Target = {
    InteractDistance = 1.5, -- Distance to interact with the newspaper
}

Config.Job = {
    name = 'reporter', -- Job name
}

Config.NewsStandsModels = {
    "prop_news_disp_02a_s", "prop_news_disp_02c", "prop_news_disp_05a", "prop_news_disp_02e",
    "prop_news_disp_03c", "prop_news_disp_06a", "prop_news_disp_02a", "prop_news_disp_02d",
    "prop_news_disp_02b", "prop_news_disp_01a", "prop_news_disp_03a"
}

Config.Locales = {
    Lang = 'en',

    Translations = {
        ['en'] = {
            STORY_PUBLISHED = 'Story was published',
            STORY_UPDATED = 'Story was updated',
            STORY_DELETED = 'Story was deleted',
            DEFAULT_PUBLISHER_NAME = 'Los Santos Publisher',
        },
    }
}