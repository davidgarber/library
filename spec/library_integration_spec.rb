Capybara.app = Sinatra::Application

describe('add a book', {:type => :feature}) do
  it('allows the user to add a new book') do
    visit('/')
    fill_in('book_title', :with => "Dante's Inferno")
    click_button('add_new_book')
    expect(page).to have_content("Dante's Inferno")
  end
end
