class Book
  attr_reader(:title, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    all_books = DB.exec('SELECT * FROM books;')
    books = []
    all_books.each() do |book|
      title = book.fetch('title')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :id => id}))
    end
    books
  end

  define_method(:==) do |another_title|
    self.title().==(another_title.title())
  end

## add a method to escape apostrophes? ##

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM books WHERE id = #{id};")
    title = result.first().fetch("title")
    Book.new({:title => title, :id => id})
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id}")
  end
end
