class GreatGameGetter::CLI

    def main_call
        intro_logo
        puts "Welcome to the Great Game Getter!"
        start
    end

    def intro_logo
        puts """
        #####                                   
        #     # #####  ######   ##   #####       
        #       #    # #       #  #    #         
        #  #### #    # #####  #    #   #         
        #     # #####  #      ######   #         
        #     # #   #  #      #    #   #         
         #####  #    # ###### #    #   #         
                                                 
         #####                                   
        #     #   ##   #    # ######             
        #        #  #  ##  ## #                  
        #  #### #    # # ## # #####              
        #     # ###### #    # #                  
        #     # #    # #    # #                  
         #####  #    # #    # ######             
                                                 
         #####                                   
        #     # ###### ##### ##### ###### #####  
        #       #        #     #   #      #    # 
        #  #### #####    #     #   #####  #    # 
        #     # #        #     #   #      #####  
        #     # #        #     #   #      #   #  
         #####  ######   #     #   ###### #    # 
                                                 
        """
    end


    def start
        puts ""
        puts "What section would you like to view information from?"
        puts ""
        puts "1 - New and Trending"
        puts "2 - Top Sellers"
        puts "3 - What's Being Played"
        puts "4 - Upcoming"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to quit the app"
        puts "----------------------------------------------------------------"


        user_input = gets.strip.to_i

        if user_input.between?(1,4)
            GreatGameGetter::Scraper.new.create_games(user_input)
            GreatGameGetter::Game.print_games(user_input)
            step_2
        elsif user_input == 5
            exit
        end

    end


    def step_2
        puts "================================================================"
        puts "****************************************************************"
        puts "================================================================"
        puts "****************************************************************"
        puts ""
        puts "What would you like to do next?"
        puts "1 - See more info about a game"
        puts "2 - Sort by platform"
        puts "3 - Sort by price"
        puts "4 - Show games by tag"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to quit the app"
        puts "----------------------------------------------------------------"

        user_input_step_2 = gets.strip.to_i

        if user_input_step_2 == 1
            
            step_see_more_info
        elsif user_input_step_2 == 2
            puts "Sort games by platform"

        elsif user_input_step_2 == 3
            puts "Sort games by price"

        elsif user_input_step_2 == 4
            puts "Sort games by tag"

        elsif user_input_step_2 == 5
            exit

        else
            puts "Invalid selection, please select 1 - 5"
            step_2
        end
    end


    def step_see_more_info
        puts "See more info about a game"

        # todo - which game would you like to see more information about?
        GreatGameGetter::Game.print_games_only

        # todo - make this look better
        puts "Which game would you like to see more information about?"

        user_input_see_more = gets.strip.to_i
        GreatGameGetter::Game.all.each_with_index do |item, index|


            if (index + 1) == user_input_see_more

                data_from_page = GreatGameGetter::Scraper.get_page_detail(item.browser_url)
                description_value_raw = data_from_page.css(".game_description_snippet").text
                description_value_clean = description_value_raw.strip

                
                puts "Game ##{index+1}."
                puts "Title: #{item.title} "

                if item.price == 0.00
                    puts "Price: FREE!"
                else
                    puts "Price: $#{item.price}"
                end
                
                puts "Platforms: #{item.platforms.join(", ")}"
                puts "Tags: #{item.tags.join(", ")}"
                puts "Link to Purchase: #{item.browser_url}" 
                puts "Link to Game Artwork: #{item.image_url}"
                puts "----------------------------------------------------------------"
                puts "------------------- MORE GAME INFO BELOW -----------------------"
                puts "----------------------------------------------------------------"
                puts "Description: #{description_value_clean}"
                puts ""
                puts ""
                
                
                # todo - get the reviews
                # todo - get the release date
                # todo - get the developer 
                # todo - get the publisher
                

                # todo - continue here print more information about a game.

                # todo - give them the ability to go back to the start

            end
        end
    end
end