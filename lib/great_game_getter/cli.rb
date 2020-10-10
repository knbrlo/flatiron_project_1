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
            step_2(user_input)
        elsif user_input == 5
            exit
        end

    end


    def step_2(section_arg)
        puts "================================================================"
        puts "****************************************************************"
        puts "================================================================"
        puts "****************************************************************"
        puts ""
        puts "What would you like to do next?"
        puts ""
        puts "1 - See more info about a game"
        puts "2 - Sort by platform"
        puts "3 - Sort by price"
        puts "4 - Show games by tag"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to quit the app"
        puts "----------------------------------------------------------------"
        puts ""

        user_input_step_2 = gets.strip.to_i

        if user_input_step_2 == 1
            
            step_see_more_info(section_arg)
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


    def step_see_more_info(section_arg)


        # get the section name so we can call it out below
        section_title = ""
        if section_arg == 1
            section_title = "NEW RELEASES"
        elsif section_arg == 2
            section_title = "TOP SELLERS"
        elsif section_arg == 3
            section_title = "WHAT'S BEING PLAYED"
        elsif section_arg == 4
            section_title = "UPCOMING"
        end

        # show all the games available to choose from to see more info about
        GreatGameGetter::Game.print_games_only

        puts ""
        puts "Which game would you like to see more information about?"
        puts ""

        user_input_see_more = gets.strip.to_i
        GreatGameGetter::Game.all.each_with_index do |item, index|


            if (index + 1) == user_input_see_more

                data_from_page = GreatGameGetter::Scraper.get_page_detail(item.browser_url)

                # get the description from the latest call
                description_value_raw = data_from_page.css(".game_description_snippet").text
                description_value_clean = description_value_raw.strip

                # get the reviews
                reviews_value_raw = data_from_page.css(".game_review_summary").text
                reviews_value_clean = reviews_value_raw.strip

                # We have a problem here where from the website we have PositivePostive for Positive
                # and MixedMixed for Mixed, now normall I'd split on a space, but there is no space
                # so to solve it splitting the chars, adding each to an array and rejoining to remove
                # the duplicate word, not duplicate characters
                array_chars_repeating = []
                array_joined_chars = []
                array_chars_original = reviews_value_clean.split("")
                string_joined_chars = ""
                array_chars_original.each do |character|

                    # add each char
                    array_chars_repeating << character

                    # pop the this char off the start of the string
                    removed_char = array_chars_original.shift

                    # add the chars to this new array so we can buid up a check
                    # when we're past 3
                    array_joined_chars << removed_char
                    string_joined_chars = array_joined_chars.join("")
                    
                end

                #final review string to use
                reviews_value_clean_final_no_dup = string_joined_chars

                # hidden review detail
                review_detail_value_raw = data_from_page.css(".nonresponsive_hidden").text
                review_detail_value_clean = review_detail_value_raw.strip

                # release date
                release_date_raw = data_from_page.css(".release_date .date").text

                # developers
                developers_raw = data_from_page.css(".dev_row #developers_list a").text
                developers_value_clean = developers_raw.gsub(" ", ", ")
                
                puts ""
                puts "Here's more information about the game you selected"
                puts ""
                puts "================================ #{section_title} ==============================="
                puts ""
                puts "---------------------------------------------------------------------------------"
                puts "********************* GAME #{index+1} - #{item.title.upcase} *********************"
                puts "---------------------------------------------------------------------------------"
                puts ""
                
                if item.price == 0.00
                    puts "Price: FREE!"
                    puts "- FREE!"
                    puts ""
                else
                    puts "Price:"
                    puts "- $#{item.price}"
                    puts ""
                end
                
                puts "Platforms:"
                puts "- #{item.platforms.join(", ")}"
                puts ""
                puts "Release Date:"
                puts "- #{release_date_raw}"
                puts ""
                puts "Tags:"
                puts "- #{item.tags.join(", ")}"
                puts ""
                puts "Review:"
                puts "- #{reviews_value_clean_final_no_dup}"
                puts ""
                puts "Review Details:"
                puts "#{review_detail_value_clean}"
                puts ""
                puts "Description:"
                puts "- #{description_value_clean.scan(/.{1,80}/).join("\n")}"
                puts ""
                puts "Link to Purchase:" 
                puts "- #{item.browser_url}"
                puts ""
                puts "Link to Game Artwork:"
                puts "- #{item.image_url}"
                puts ""
                puts "Developers:"
                puts "#{developers_value_clean}"
                puts ""
                puts "---------------------------------------------------------------------------------"
                puts ""

                start_over_or_see_another_game
            end
        end
    end


    def start_over_or_see_another_game
        puts "================================================================"
        puts "****************************************************************"
        puts "================================================================"
        puts "****************************************************************"
        puts ""
        puts "What would you like to do next?"
        puts ""
        puts "1 - Select a different section"
        puts "2 - See info about another game"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to quit the app"
        puts "----------------------------------------------------------------"
        puts ""

        user_input  = gets.strip.to_i

        if user_input == 1
            start
        elsif user_input == 2
            step_see_more_info(user_input)
        elsif user_input == 5
            exit
        end
    end

end