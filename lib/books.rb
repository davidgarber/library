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

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM books WHERE id = #{id};")
    title = result.first().fetch("title")
    Book.new({:title => title, :id => id})
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id}")

    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO books_authors (id_books, id_authors) VALUES (#{self.id()}, #{author_id});")
    end
  end

  define_method(:authors) do
    book_authors = []
    results = DB.exec("SELECT id_authors FROM books_authors WHERE id_books = #{self.id()};")
    results.each() do |result|
      id_author = result.fetch('id_authors').to_i()
      author = DB.exec("SELECT * FROM authors WHERE id = #{id_author};")
      name = author.first().fetch('author')
      book_authors.push(Author.new({:name => name, :id => id_author}))
    end
    book_authors
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
    DB.exec("DELETE FROM books_authors WHERE id_books = #{self.id()};")
  end
end
