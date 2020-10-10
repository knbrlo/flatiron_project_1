class GreatGameGetter::Scraper

    def get_page
        Nokogiri::HTML(open("https://store.steampowered.com/games/"))
    end

    def scrape_game_page(page_num_arg)
        if page_num_arg == 1
            self.get_page.css("#tab_content_NewReleases a")
        elsif page_num_arg == 2
            self.get_page.css("#tab_content_TopSellers a")
        elsif page_num_arg == 3
            self.get_page.css("#tab_content_ConcurrentUsers a")
        elsif page_num_arg == 4
            self.get_page.css("#tab_content_ComingSoon a")
        end
    end

    def create_games(page_num_arg)

        # when a new number is pressed, then clear out the old results
        # p GreatGameGetter::Game.all.count
        # GreatGameGetter::Game.clear_all
        # p GreatGameGetter::Game.all.count

        data_from_scrape = nil;
        if page_num_arg.between?(1,4)
            data_from_scrape = scrape_game_page(page_num_arg)
            data_from_scrape.each do |game|
                GreatGameGetter::Game.new_from_page(game)
            end
        else
            puts "Invalid selection, please select 1 - 4"
        end
    end

end

