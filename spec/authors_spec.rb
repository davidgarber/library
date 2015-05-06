require 'spec_helper'

describe(Author) do

  describe('#author') do
    it('return the author') do
      author_test = Author.new({:author => 'Terry Pratchet', :id => nil})
      expect(author_test.author()).to(eq('Terry Pratchet'))
    end
  end
  
end
