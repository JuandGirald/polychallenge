Dir.glob('lib/*.rb').each { |r| import r }
Dir.glob('lib/polychallenge/*.rb').each { |r| import r }

task :rebuild, :environment do
  desc "download the category tree from EbayAPI and create the SQLite database"
  
  data = Polychallenge::SqliteDatabase.new()
  data.connect
  data.create_table
  p "Storing category tree in the database..."

  Polychallenge::CategoryStored.create(data)
end

desc "generate a template displaying the category tree rooted at the given ID"
task :render, [:amount] do |t, args|
  erb_file = 'template.html.erb'
  html_file = "#{args.amount}.html" #=>"page.html"

  erb_str = File.read(erb_file)

  data = Polychallenge::SqliteDatabase.new()
  data.connect
  @categories = data.find_data(args.amount)

  if @categories.empty?
    p "No category with ID: " + "#{args.amount}"
  else
    renderer = ERB.new(erb_str)
    result = renderer.result()

    File.open(html_file, 'w') do |f|
      f.write(result)
    end
  end 
end
