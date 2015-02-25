require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)

    visit beerlist_path
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    expect(page).to have_content "Nikolai"
  end

  it "shows beers ordered by name", js: true do
     get_beers

     expect(@olut1).to have_content 'Fastenbier'
     expect(@olut2).to have_content 'Lechte Weisse'
     expect(@olut3).to have_content 'Nikolai'
  end

  it "after clicking style, beers are ordered alphabetically by style", js: true do
     click_link "style"

     get_beers

     expect(@olut1).to have_content 'Lager'
     expect(@olut2).to have_content 'Rauchbier'
     expect(@olut3).to have_content 'Weizen'
  end

  it "after clicking brewery, beers are ordered alphabetically by brewery", js: true do
     click_link "brewery"

     get_beers

     expect(@olut1).to have_content 'Ayinger'
     expect(@olut2).to have_content 'Koff'
     expect(@olut3).to have_content 'Schlenkerla'
  end

  def get_beers
     @olut1 = find('table').find('tr:nth-child(2)')
     @olut2 = find('table').find('tr:nth-child(3)')
     @olut3 = find('table').find('tr:nth-child(4)')     
  end
end
