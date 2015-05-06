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
end
