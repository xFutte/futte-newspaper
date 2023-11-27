Config = {
    BuyNewspaperText = 'Buy Newspaper', -- Text shown with qb-target
    BuyNewspaperIcon = 'fas fa-newspaper',-- Icon shown with qb-target
    Price = 100, -- Price of buying the newspaper
    AmountOfNews = 10, -- Amount of news to be fetched from the database
    AmountOfSentences = 10, -- Amount of prison sentences to be fetched from the database
    
    -- List of supported

    Inventories = {
        QB_INVENTORY = 'qb-inventory', 
        OX_INVENTORY = 'ox_inventory',
    },

    Items = {
        NEWSPAPER = 'newspaper', -- Item name for the newspaper
    },

    DisableInitInfo = false, -- If you want to disable resource information on its start then set it to true, otherwise set it to false.

    UseOxInventory = false, -- If you are using ox_inventory set this to true, otherwise set it to false.
    
    Inventory = nil, -- [[ 'qb-inventory, 'ox-inventory']] Inventory to use, if not defined it will try to detect it automatically.
    Framework = nil, -- [[ 'ESX', 'QBCORE' ]] -- Framework to use, if not defined it will try to detect it automatically.
    
    Target = {
        InteractDistance = 1.5, -- Distance to interact with the newspaper
    },
    
    Job = {
        name = 'reporter', -- Job name
    },
    
    NewsStandsModels = {
        "prop_news_disp_02a_s", "prop_news_disp_02c", "prop_news_disp_05a", "prop_news_disp_02e",
        "prop_news_disp_03c", "prop_news_disp_06a", "prop_news_disp_02a", "prop_news_disp_02d",
        "prop_news_disp_02b", "prop_news_disp_01a", "prop_news_disp_03a"
    },
    
    Locales = {
        Lang = 'en',
    
        Translations = {
            ['en'] = {
                STORY_PUBLISHED = 'Story was published',
                STORY_UPDATED = 'Story was updated',
                STORY_DELETED = 'Story was deleted',
                DEFAULT_PUBLISHER_NAME = 'Los Santos Publisher',
                NOT_ALLOWED = 'You are not allowed to do this',
                NOT_ENOUGH_MONEY = 'You do not have enough money',
            },
        }
    }
}


