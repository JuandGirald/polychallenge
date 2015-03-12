module Polychallenge
  class CategoryStored
    # Public: Create and save categories objects with the EbayApi data
    #
    # Returns the data saved in the SQLite database
    def self.create(database)
      category_array.each do |data|
        database.insert_data(data['CategoryID'], data['CategoryLevel'], data['CategoryName'],
                            data['CategoryParentID'], data['LeafCategory'], data['BestOfferEnabled'],
                            data['AutoPayEnabled'], data['LSD'])
      end
    end

    # Public:
    #
    # Examples
    #
    #    category_array()
    #    # => [{"BestOfferEnabled"=>"true", "AutoPayEnabled"=>"true", "CategoryID"=>"20081", "CategoryLevel"=>"1", 
    #          "CategoryName"=>"Antiques", "CategoryParentID"=>"20081"}, 
    #         {"BestOfferEnabled"=>"true", "AutoPayEnabled"=>"true", "CategoryID"=>"37903", "CategoryLevel"=>"2", 
    #          "CategoryName"=>"Antiquities", "CategoryParentID"=>"20081"}]
    #
    # Returns an array of hashes with the category tree
    # from the EbayAPI 
    def self.category_array
      EbayApi.apicall
    end
  end
end