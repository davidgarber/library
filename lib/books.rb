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

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
end
