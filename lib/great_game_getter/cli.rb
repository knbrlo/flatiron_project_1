class GreatGameGetter::CLI

    def main_call
        page_info = GreatGameGetter::Scraper.new.scrape_game_page(1)
        p page_info
    end

end