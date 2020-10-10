class GreatGameGetter::Game
    attr_accessor :title, :platforms, :tags, :price

    @@all = []

    def initialize(title_arg=nil, platforms_arg=[],  tags_arg=[], price_arg=nil)
        @title = title_arg
        @platforms = platforms_arg
        @tags = tags_arg
        @price = price_arg
        @@all << self
    end


    def self.new_from_page(game_arg)
        
        name_value = game_arg.css(".tab_item_name").text

        platform_values_raw = game_arg.css(".tab_item_details span")
        array_platforms = []

        platform_values_raw.each do |item|
            item_class_name = item.attr("class")

            if item_class_name.include?("platform_img win")
                array_platforms << "win"
            elsif item_class_name.include?("platform_img mac")
                array_platforms << "mac"
            elsif item_class_name.include?("platform_img linux")
                array_platforms << "linux"
            end
        end

        tag_values_raw = game_arg.css(".tab_item_top_tags")
        array_tags = []

        tag_values_raw.each do |item|
            tag_name = item.text
            clean_tag_name = tag_name.gsub(", ", "")
            array_tags << clean_tag_name
        end

        price_value = game_arg.css(".discount_final_price").text
        clean_price_value = price_value.gsub("$", "").to_f

        self.new(name_value, array_platforms, array_tags, clean_price_value)
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
                puts "========== NEW RELEASES ============="
                puts ""
                puts ""
            elsif page_arg == 2
                puts ""
                puts ""
                puts "========== TOP SELLERS ============="
                puts ""
                puts ""
            elsif page_arg == 3
                puts ""
                puts ""
                puts "========== WHAT'S BEING PLAYED ============="
                puts ""
                puts ""
            elsif page_arg == 4
                puts ""
                puts ""
                puts "========== UPCOMING ============="
                puts ""
                puts ""
            end

            @@all.each_with_index do |item, index|

                if !item.title.empty?
                    puts "#{index+1}. - #{item.title} "
                    puts ""
                end
            end
        else
            puts "Invalid selection, please select pages 1 - 4"
        end
    end
end