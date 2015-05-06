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
  @new_book = params.fetch('book_title')
  book = Book.new({:title => @new_book, :id => nil})
  book.save()
  @books = Book.all()
  erb(:add_new_book)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

get('/add/book') do
  erb(:add_new_book)
end

get('/add/author') do
  erb(:add_author)
end

post('/author/new') do
  @new_author = params.fetch('new_author')
  name = Author.new({:name => @new_author, :id => nil})
  name.save()
  @authors = Author.all()
  erb(:add_author)
end

  get('/authors') do
    @authors = Author.all()
    erb(:authors)
  end
