require 'spec_helper'

describe(Author) do

  describe('#name') do
    it('return the author') do
      author_test = Author.new({:name => 'Terry Pratchet', :id => nil})
      expect(author_test.name()).to(eq('Terry Pratchet'))
    end
  end

  describe('#id') do
    it('returns the id for a book') do
      test_author = Author.new({:name => 'Orson S Card', :id => nil})
      test_author.save()
      expect(test_author.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".all") do
    it("returns an empty array") do
      expect(Author.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves an author to the array") do
      author_test = Author.new({:name => 'Terry Pratchet', :id => nil})
      author_test.save()
      expect(Author.all()).to(eq([author_test]))
    end
  end

  describe("#==") do
    it("author names are the same then authors are the same") do
      author1 = Author.new({:name => 'Terry Pratchet', :id => nil})
      author2 = Author.new({:name => 'Terry Pratchet', :id => nil})
      expect(author1).to(eq(author2))
    end
  end

end
