class GreatGameGetter::Game
    attr_accessor :title, :platforms, :tags, :price, :browser_url, :image_url

    @@all = []

    def initialize(title_arg=nil, platforms_arg=[],  tags_arg=[], price_arg=nil, browser_url_arg=nil, image_url_arg=nil)
        @title = title_arg
        @platforms = platforms_arg
        @tags = tags_arg
        @price = price_arg
        @browser_url = browser_url_arg
        @image_url = image_url_arg

        # add this instance to the @@all
        @@all << self
    end


    def self.new_from_page(game_arg)

        # get the name value of the game
        name_value = game_arg.css(".tab_item_name").text

        # platform values
        platform_values_raw = game_arg.css(".tab_item_details span")
        array_platforms = []

        platform_values_raw.each do |item|

            item_class_name = item.attr("class")

            if item_class_name.include?("platform_img win")
                array_platforms << "Windows"
            elsif item_class_name.include?("platform_img mac")
                array_platforms << "Mac"
            elsif item_class_name.include?("platform_img linux")
                array_platforms << "Linux"
            end
        end

        # tag values
        tag_values_raw = game_arg.css(".tab_item_top_tags")
        array_tags = []

        tag_values_raw.each do |item|
            tag_name = item.text
            array_tags << tag_name
        end

        # price
        price_value = game_arg.css(".discount_final_price").text
        clean_price_value = price_value.gsub("$", "").to_f

        # url 
        url_for_game = game_arg.attribute("href").value

        # image
        image_url_for_game = game_arg.css(".tab_item_cap_img").attribute("src")

        # create the ne object
        self.new(name_value, array_platforms, array_tags, clean_price_value, url_for_game, image_url_for_game)
    end

    def self.all
        @@all
    end

    def self.clear_all
        @@all.clear
    end

    def self.print_games(page_arg)

        if page_arg.between?(1,4)

            if page_arg == 1
                puts ""
                puts ""
                puts "************************************************************"
                puts "==================== NEW RELEASES =========================="
                puts "************************************************************"
                puts ""
                puts ""
            elsif page_arg == 2
                puts ""
                puts ""
                puts "***********************************************************"
                puts "==================== TOP SELLERS =========================="
                puts "***********************************************************"
                puts ""
                puts ""
            elsif page_arg == 3
                puts ""
                puts ""
                puts "************************************************************"
                puts "================= WHAT'S BEING PLAYED ======================"
                puts "************************************************************"
                puts ""
                puts ""
            elsif page_arg == 4
                puts ""
                puts ""
                puts "************************************************************"
                puts "======================= UPCOMING ==========================="
                puts "************************************************************"
                puts ""
                puts ""
            end

            print_games_only
        else
            puts "Invalid selection, please select 1 - 4"
        end
    end


    def self.print_games_only
        @@all.each_with_index do |item, index|

            if !item.title.empty?
                puts "Game ##{index+1}."
                puts "Title: #{item.title} "

                if item.price == 0.00
                    puts "Price: FREE!"
                else
                    puts "Price: $#{item.price}"
                end
                
                puts "Platforms: #{item.platforms.join(", ")}"
                puts "Tags: #{item.tags.join(", ")}"
                puts "----------------------------------------------------------------"
                puts ""
            end
        end
    end



    def self.print_games_find_by_platform(section_arg)

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

        puts "================================================================"
        puts "****************************************************************"
        puts "================================================================"
        puts "****************************************************************"
        puts ""
        puts "What platform would you like to search by?"
        puts ""
        puts "1 - Windows"
        puts "2 - Mac"
        puts "3 - Linux"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to restart the app"
        puts "----------------------------------------------------------------"
        puts "Press 9 to quit the app"
        puts "----------------------------------------------------------------"
        puts ""

        user_input = gets.strip.to_i
        platform_selected = ""

        if user_input == 1
            platform_selected = "Windows"
        elsif user_input == 2
            platform_selected = "Mac"
        elsif user_input == 3
            platform_selected = "Linux"
        elsif user_input == 5
            GreatGameGetter::CLI.start_from_outside
        elsif user_input == 9
            exit
        else
            puts "Invalid selection, please select 1 - 3"
            print_games_find_by_platform(section_arg)
        end
        
        puts ""
        puts "Here's more information about #{platform_selected} games from the #{section_title} section."
        puts ""

        @@all.each_with_index do |item, index|
            if !item.title.empty?
                if item.platforms.include?(platform_selected)
                    puts "Game ##{index+1}."
                    puts "Title: #{item.title} "
    
                    if item.price == 0.00
                        puts "Price: FREE!"
                    else
                        puts "Price: $#{item.price}"
                    end
                    
                    puts "Platforms: #{item.platforms.join(", ")}"
                    puts "Tags: #{item.tags.join(", ")}"
                    puts "----------------------------------------------------------------"
                    puts ""
                end  
            end
        end

        what_would_like_to_do_next(section_arg)
    end

    def self.print_games_sorted_by_price(section_arg)

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

        puts "================================================================"
        puts "****************************************************************"
        puts "================================================================"
        puts "****************************************************************"
        puts ""
        puts "What would you like to search by?"
        puts ""
        puts "1 - Highest to Lowest"
        puts "2 - Lowest to Highest"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to restart the app"
        puts "----------------------------------------------------------------"
        puts "Press 9 to quit the app"
        puts "----------------------------------------------------------------"
        puts ""

        user_input = gets.strip.to_i
        order_selected = ""

        if user_input == 1
            order_selected = "Highest First"
        elsif user_input == 2
            order_selected = "Lowest First"
        elsif user_input == 5
            GreatGameGetter::CLI.start_from_outside
        elsif user_input == 9
            exit
        else
            puts "Invalid selection, please select 1 - 2"
            print_games_sorted_by_price(section_arg)
        end
        
        sorted_by_price = []

        puts ""

        if order_selected == "Highest First"
            puts "Games from the #{section_title} section, sorted highest to lowest."
            sorted_by_price = @@all.sort {|x, y| y.price <=> x.price}
        elsif order_selected == "Lowest First"
            puts "Games from the #{section_title} section, sorted lowest to highest."
            sorted_by_price = @@all.sort {|x, y| x.price <=> y.price}
        end

        puts ""

        sorted_by_price.each_with_index do |item, index|
            if !item.title.empty?
                puts "Game ##{index+1}."
                puts "Title: #{item.title} "

                if item.price == 0.00
                    puts "Price: FREE!"
                else
                    puts "Price: $#{item.price}"
                end
                
                puts "Platforms: #{item.platforms.join(", ")}"
                puts "Tags: #{item.tags.join(", ")}"
                puts "----------------------------------------------------------------"
                puts "" 
            end
        end

        what_would_like_to_do_next(section_arg)
    end

    def self.what_would_like_to_do_next(section_arg)
        puts "================================================================"
        puts "****************************************************************"
        puts "================================================================"
        puts "****************************************************************"
        puts ""
        puts "What would you like to do next?"
        puts ""
        puts "1 - Filter by platform"
        puts "2 - Sort by price"
        puts ""
        puts "----------------------------------------------------------------"
        puts "Press 5 to restart the app"
        puts "----------------------------------------------------------------"
        puts "Press 9 to quit the app"
        puts "----------------------------------------------------------------"
        puts ""

        user_input = gets.strip.to_i
        

        if user_input == 1
            self.print_games_find_by_platform(section_arg)
        elsif user_input == 2
            self.print_games_sorted_by_price(section_arg)
        elsif user_input == 5
            GreatGameGetter::CLI.start_from_outside
        elsif user_input == 9
            exit
        end
        
    end

end