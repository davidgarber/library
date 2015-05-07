require 'spec_helper'

describe(Book) do
  describe('#title') do
    it('returns the title for a book') do
      test_book = Book.new({:title => 'To Kill a Mockingbird', :id => nil})
      expect(test_book.title()).to(eq('To Kill a Mockingbird'))
    end
  end

  describe('#id') do
    it('returns the id for a book') do
      test_book = Book.new({:title => 'To Kill a Mockingbird', :id => nil})
      test_book.save()
      expect(test_book.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".all") do
    it("starts off with no books") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a book to the database') do
      test_book = Book.new({:title => 'To Kill a Mockingbird', :id => nil})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe("#==") do
    it('is the same book if it has the same name') do
      book1 = Book.new({:title => 'To Kill a Mockingbird', :id => nil})
      book2 = Book.new({:title => 'To Kill a Mockingbird', :id => nil})
      expect(book1).to(eq(book2))
    end
  end

  describe(".find") do
    it("returns a book by its ID number") do
      test_book1 = Book.new({:title => "Catcher in the Rye", :id => nil})
      test_book1.save()
      test_book2 = Book.new({:title => "War of the Worlds", :id => nil})
      test_book2.save()
      expect(Book.find(test_book2.id())).to(eq(test_book2))
    end
  end

  describe("#update") do
    it("lets you update books in the database") do
      book = Book.new({:title => "Green eggs and Ham", :id => nil})
      book.save()
      book.update({:title => "The Lorax"})
      expect(book.title()).to(eq("The Lorax"))
    end
  end
    it("lets you add an author to a book") do
      book = Book.new({:title => "For Whom the Bell Tolls", :id => nil})
      book.save()
      ernest = Author.new({:name => "Ernest Hemingway", :id => nil})
      ernest.save()
      brad = Author.new({:name => "Brad Pitt", :id => nil})
      brad.save()
      book.update({:author_ids => [ernest.id(), brad.id()]})
      expect(book.authors()).to(eq([ernest, brad]))
    end
  end

  describe("#authors") do
    it("returns all of the authors in a particular book") do
      book = Book.new({:title => "The Jell Bar", :id => nil})
      book.save()
      george = Author.new({:name => "George Clooney", :id => nil})
      george.save()
      brad = Author.new({:name => "Brad Pitt", :id => nil})
      brad.save()
      book.update({:author_ids => [george.id(), brad.id()]})
      expect(book.authors()).to(eq([george, brad]))
    end
  end

  describe("#delete") do
    it("lets you delete a book from the database") do
      book1 = Book.new({:title => "Oceans", :id => nil})
      book1.save()
      book2 = Book.new({:title => "The life of Pi", :id => nil})
      book2.save()
      book1.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end
