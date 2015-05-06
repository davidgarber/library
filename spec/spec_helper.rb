require 'rspec'
require 'books'
require 'authors'
require 'checkout'
require 'copies'
require 'patrons'
require 'pg'
require 'capybara/rspec'
require 'pry'
require './app'


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM books_authors *;")
    DB.exec("DELETE FROM checkout *;")
    DB.exec("DELETE FROM copies *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM patrons_copies *;")
  end
end

set(:show_exceptions, false)
