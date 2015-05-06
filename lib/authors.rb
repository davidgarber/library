class Author
  attr_reader(:author, :id)

  define_method(:initialize) do |attributes|
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end
end
