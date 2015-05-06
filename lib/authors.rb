class Author
  attr_reader(:author, :id)

  define_method(:initialize) do |attributes|
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    all_authors = DB.exec('SELECT * FROM authors')
    authors = []
    all_authors.each() do |author|
      author = author.fetch(:author)
      id = author.fetch(:id).to_i()
      authors.push(Author.new({:author => author, :id => id}))
    end
    authors

  end
end
