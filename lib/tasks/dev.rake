namespace :dev do

  task :fake => :environment do
    Product.delete_all

    1000.times do
      Product.create!( :name => FFaker::Name.first_name,
                       :price => ( rand(500)+1 ) * 10 ,
                       :image_url => FFaker::Avatar.image,
                       :description => FFaker::Lorem.paragraph,
                       :in_stock_qty => rand(30) )
    end

    puts "have created fake products"
  end
end


