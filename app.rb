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

get('/author/:id') do
  @id = params.fetch('id').to_i()
  @author = Author.find(@id)
  @authors_books = @author.books()
  @books = Book.all()
  erb(:author)
end

patch('/author/:id') do
  @id = params.fetch('id').to_i()
  @author = Author.find(@id)
  book_ids = params.fetch('book_ids')
  @author.update({:book_ids => book_ids})
  @books = Book.all()
  @authors_books = @author.books()
  erb(:author)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

get('/book/:id') do
  @id = params.fetch('id').to_i()
  @book = Book.find(@id)
  @books_authors = @book.authors()
  @authors = Author.all()
  erb(:book)
end

patch('/book/:id') do
  @id = params.fetch('id').to_i()
  @book = Book.find(@id)
  author_ids = params.fetch('author_ids')
  @book.update({:author_ids => author_ids})
  @authors = Author.all()
  @books_authors = @book.authors()
  erb(:book)
end
