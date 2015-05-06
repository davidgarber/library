require 'spec_helper'

describe(Book) do
  describe('#title') do
    it('returns the title for a book') do
      test_book = Book.new({:title => 'To Kill a Mockingbird', :id => nil})
      expect(test_book.title()).to(eq('To Kill a Mockingbird'))
    end
  end
  

end
