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
        @@all << self
    end


    def self.new_from_page(game_arg)

        name_value = game_arg.css(".tab_item_name").text

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

        tag_values_raw = game_arg.css(".tab_item_top_tags")
        array_tags = []

        tag_values_raw.each do |item|
            tag_name = item.text
            array_tags << tag_name
        end

        price_value = game_arg.css(".discount_final_price").text
        clean_price_value = price_value.gsub("$", "").to_f

        url_for_game = game_arg.attribute("href").value

        image_url_for_game = game_arg.css(".tab_item_cap_img").attribute("src")

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

end