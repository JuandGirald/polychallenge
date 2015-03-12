module Polychallenge
  
  # SQLite database for category tree
  #
  class SqliteDatabase
    def connect
      @db = SQLite3::Database.new "test.db"
    end

    def create_table
      @db.execute "DROP TABLE IF EXISTS categories"
      @db.execute <<-SQL
        create table categories (
          categoryID        int,
          categoryLevel     int,
          categoryName      varchar(255),
          categoryParentID  int,
          leafCategory      boolean,
          bestOfferEnabled  boolean,
          autoPayEnabled    boolean,
          lsd               boolean
        );
      SQL
    end

    def insert_data(categoryId, categoryLevel, categoryName, categoryParentID, leafCategory, bestOfferEnabled, autoPayEnabled, lsd)
      @db.execute("INSERT INTO categories (categoryID, categoryLevel, categoryName, categoryParentID, leafCategory,
                bestOfferEnabled, autoPayEnabled, lsd) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)", categoryId, categoryLevel, categoryName, categoryParentID, leafCategory,
                bestOfferEnabled, autoPayEnabled, lsd)
    end

    def find_data(categoryParentId)
      rows = []
      @db.execute( "select * from categories  where categoryParentID=#{categoryParentId}" ) do |row|
         rows << row
      end
      rows
    end

    def close
      @db.close
    end
  end
end
