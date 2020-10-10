class GreatGameGetter::CLI

    def main_call
        puts "Welcome to the Great Game Getter!"
        start
    end

    def start
        puts ""
        puts "What section would you like to view information from?"
        puts "1 - New and Trending"
        puts "2 - Top Sellers"
        puts "3 - What's Being Played"
        puts "4 - Upcoming"

        # todo - breaks here if they just press enter.

        user_input = gets.strip.to_i

        p "selected #{user_input}"
        page_info = GreatGameGetter::Scraper.new.create_games(user_input)
    end

end