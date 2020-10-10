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

    def scrape_game_page(page_num_arg)
        if page_num_arg == 1
            self.get_page_new_trending.css(".tabarea .tab_item_name").text
        elsif page_num_arg == 2
            self.get_page_top_sellers.css("")
        elsif page_num_arg == 3
            self.get_page_being_played.css("")
        elsif page_num_arg == 4
            self.get_page_coming_soon.css("")
        end
    end

end

