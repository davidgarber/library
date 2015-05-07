require('launchy')

Capybara.app = Sinatra::Application

describe('add a book', {:type => :feature}) do
  it('allows the user to add a new book') do
    visit('/')
    click_button('add_books')
    fill_in('book_title', :with => "Dantes Inferno")
    click_button('add_new_book')
    expect(page).to have_content("Dantes Inferno")
  end
end

describe('add an author', {:type => :feature}) do
  it('allows the user to add a new author') do
    visit('/')
    click_button('add_author')
    fill_in('new_author', :with => "Ernest Hemingway")
    click_button('add_new_author')
    expect(page).to have_content("Ernest Hemingway")
  end
end

describe('delete an author', {:type => :feature}) do
  it('allows the user to delete an author') do
    visit('/')
    click_button('add_author')
    fill_in('new_author', :with => "Ernest Hemingway")
    click_button('add_new_author')
    click_button("authors")
    click_link("Ernest Hemingway")
    click_button("delete_author")
    expect(page).to_not have_content("Ernest Hemingway")
  end
end
