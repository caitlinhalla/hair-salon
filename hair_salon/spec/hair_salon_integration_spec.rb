require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new client and stylist', {:type => :feature}) do
  it('allows the user to add a new stylist') do
    visit('/')
    fill_in('name', :with => 'Mandy')
    click_button('Add Stylist')
    expect(page).to have_content('Mandy')
  end
end

describe('seeing details for a single stylist', {:type => :feature}) do
  it('allows a user to click on a stylist to view their details') do
    stylist = Stylist.new({:name => "Sam", :id => nil})
    stylist.save
    client = Client.new({:name => "Blam", :id => nil, :appointment_time => "2016-12-12 00:12:00", :stylist_id => stylist.id})
    client.save
    visit('/')
    click_link(stylist.name)
    expect(page).to have_content(stylist.name)
  end
end

describe('editing a stylist', {:type => :feature}) do
  it('allows you to edit a stylists details') do
    stylist = Stylist.new({:name => "Sam", :id => nil})
    stylist.save
    client = Client.new({:name => "Blam", :id => nil, :appointment_time => "2016-12-12 00:12:00", :stylist_id => stylist.id})
    client.save
    visit('/')
    click_link(stylist.name)
    click_link("Edit #{stylist.name}")
    expect(page).to have_content("Update")
  end

  it('allows you to delete a stylist') do
    stylist = Stylist.new({:name => "Sam", :id => nil})
    stylist.save
    client = Client.new({:name => "Blam", :id => nil, :appointment_time => "2016-12-12 00:12:00", :stylist_id => stylist.id})
    client.save
    visit('/')
    click_link(stylist.name)
    click_link("Edit #{stylist.name}")
    click_button("Delete Stylist")
    expect(page).to have_content("Hair Salon")
  end
end
