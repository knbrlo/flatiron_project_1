class GreatGameGetter::Game
    attr_accessor :title, :platforms, :tags, :price


    def initialize(title_arg=nil, platforms_arg=[],  tags_arg=[], price_arg=nil)
        @title = title_arg
        @platforms = platforms_arg
        @tags = tags_arg
        @price = price_arg
    end


    def self.new_from_page(game_arg)
        
        # title
        name_value = game_arg.css(".tab_item_name").text


        # platform
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


        # details
        tag_values_raw = game_arg.css(".tab_item_top_tags")
        array_tags = []

        tag_values_raw.each do |item|
            tag_name = item.text
            clean_tag_name = tag_name.gsub(", ", "")
            array_tags << clean_tag_name
        end

        # price
        price_value = game_arg.css(".discount_final_price").text

        clean_price_value = price_value.gsub("$", "")

        sample_item = self.new(name_value, array_platforms, array_tags, clean_price_value)
        p sample_item
        sample_item
    end
end