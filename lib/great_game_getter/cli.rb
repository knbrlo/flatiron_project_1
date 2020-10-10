class GreatGameGetter::CLI

    def main_call
        puts "Welcome to the Great Game Getter!"
        start
    end

    def start
        puts ""
        puts "What section would you like to view information from?"
        puts ""
        puts "1 - New and Trending"
        puts "2 - Top Sellers"
        puts "3 - What's Being Played"
        puts "4 - Upcoming"

        # todo - breaks here if they just press enter.

        user_input = gets.strip.to_i
        GreatGameGetter::Scraper.new.create_games(user_input)
        GreatGameGetter::Game.print_games(user_input)
        step_2
    end


    def step_2
        puts "================================"
        puts "********************************"
        puts "================================"
        puts "********************************"
        puts ""
        puts "What would you like to do next?"
        puts ""
        puts "1 - See more information about a game"
        puts "2 - Sort by platform"
        puts "3 - Sort by price"
        puts "4 - Show games by tag"
        puts ""

        user_input_step_2 = gets.strip.to_i

        if user_input_step_2 == 1
            puts "See more info about a game"

        elsif user_input_step_2 == 2
            puts "Sort games by platform"

        elsif user_input_step_2 == 3
            puts "Sort games by price"

        elsif user_input_step_2 == 4
            puts "Sort games by tag"

        else
            puts "Invalid selection, please select 1 - 4"
            step_2
        end
    end

end