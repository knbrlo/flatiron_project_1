class GreatGameGetter::Scraper

    def get_page_new_trending
        Nokogiri::HTML(open("https://store.steampowered.com/games/#p=0&tab=NewReleases"))
    end

    def get_page_top_sellers
        Nokogiri::HTML(open("https://store.steampowered.com/games/#p=0&tab=TopSellers"))
    end

    def get_page_being_played
        Nokogiri::HTML(open("https://store.steampowered.com/games/#p=0&tab=ConcurrentUsers"))
    end

    def get_page_coming_soon
        Nokogiri::HTML(open("https://store.steampowered.com/games/#p=0&tab=ComingSoon"))
    end

end