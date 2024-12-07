namespace :connect_user_to_book do
  desc "Connect User to Book"
  task :execute, [:user_id, :book_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    book = Book.find(args[:book_id])

    raise "The book already has author!" if book.author.present?
    book.author = user
    book.save!

    puts "User #{user.display_name} is connected to Book #{book.title}"
  end
end
