class Author
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    all_authors = DB.exec('SELECT * FROM authors;')
    authors = []
    all_authors.each() do |each_entry|
      author = each_entry.fetch('author')
      id = each_entry.fetch('id').to_i()
      authors.push(Author.new({:name => author, :id => id}))
    end
    authors
  end

  define_method(:save) do
    returns = DB.exec("INSERT INTO authors (author) VALUES ('#{@name}') RETURNING id;")
    @id = returns.first().fetch('id').to_i()
  end

  define_method(:==) do |other_object|
    self.name().==(other_object.name())
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM authors WHERE id = #{id};")
    author = result.first().fetch("author")
    Author.new({:name => author, :id => id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET author = '#{@name}' WHERE id = #{@id}")

    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO books_authors ( id_authors, id_books) VALUES (#{self.id()}, #{book_id});")
    end
  end

  define_method(:books) do
    book_authors = []
    results = DB.exec("SELECT id_books FROM books_authors WHERE id_authors = #{self.id()};")
    results.each() do |result|
      id_book = result.fetch('id_books').to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{id_book};")
      title = book.first().fetch('title')
      book_authors.push(Book.new({:title => title, :id => id_book}))
    end
    book_authors
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
    DB.exec("DELETE FROM books_authors WHERE id_authors = #{self.id()};")
  end
end
