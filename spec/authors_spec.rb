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

  describe(".find") do
    it("returns an author by its ID number") do
      test_author1 = Author.new({:name => "Terry Pratchett", :id => nil})
      test_author1.save()
      test_author2 = Author.new({:name => "Ernest Hemingway", :id => nil})
      test_author2.save()
      expect(Author.find(test_author2.id())).to(eq(test_author2))
    end
  end

  describe("#update") do
    it("lets you update authors in the database") do
      author = Author.new({:name => "Terry Pratchett", :id => nil})
      author.save()
      author.update({:name => "Ernest Hemingway"})
      expect(author.name()).to(eq("Ernest Hemingway"))
    end
  end
    it("lets you add an book to a author") do
      author = Author.new({:name => "Ernest Hemingway", :id => nil})
      author.save()
      whom = Book.new({:title => "For Whom the Bell Tolls", :id => nil})
      whom.save()
      sun = Book.new({:title => "The Sun Also Rises", :id => nil})
      sun.save()
      author.update({:book_ids => [whom.id(), sun.id()]})
      expect(author.books()).to(eq([whom, sun]))
    end
  end

  describe("#books") do
    it("returns all of the books by a particular author") do
      author = Author.new({:name => "Sylvia Plath", :id => nil})
      author.save()
      bell = Book.new({:title => "The Bell Jar", :id => nil})
      bell.save()
      jell = Book.new({:title => "The Jell Bar", :id => nil})
      jell.save()
      author.update({:book_ids => [bell.id(), jell.id()]})
      expect(author.books()).to(eq([bell, jell]))
    end
  end
