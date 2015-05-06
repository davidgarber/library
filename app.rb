require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/authors')
require('pg')
also_reload './lib/**/*.rb'

DB = PG.connect({:dbname => 'library'})

get('/') do
  @books = Book.all()
  erb(:index)
end

post('/book/new') do
  new_book = params.fetch('book_title')
  book = Book.new({:title => new_book, :id => nil})
  book.save()
  @books = Book.all()
  erb(:books)
end
