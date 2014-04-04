require 'rspec'
require 'url_database'

describe URLdb do

  let(:db) { Sequel.connect('postgres://gschool_user:password@localhost:5432/url_database_test') }

  before do
    db.create_table :urls do
      primary_key :id
      String :original_url, :null=>false
      String :new_url, :null=>false
    end

    @repo = URLdb.new(db)

  end

  after do
    db.drop_table :urls
  end

  it 'allows for creating of a task' do
    @repo.create({:original_url => "http://www.google.com", :new_url => "http://localhost:9292/1"})
    @repo.create({:original_url => "http://www.facebook.com", :new_url => "http://localhost:9292/2"})
    expect(@repo.all).to eq [
                              {:id => 1, :original_url => "http://www.google.com", :new_url => "http://localhost:9292/1"},
                              {:id => 2, :original_url => "http://www.facebook.com", :new_url => "http://localhost:9292/2"}
                            ]
  end

  it 'allows a url to be deleted from the table' do
    @repo.create({:original_url => "http://www.google.com", :new_url => "http://localhost:9292/1"})
    @repo.create({:original_url => "http://www.facebook.com", :new_url => "http://localhost:9292/2"})
    @repo.delete(2)
    expect(@repo.all).to eq [{:id => 1, :original_url => "http://www.google.com", :new_url => "http://localhost:9292/1"}]
  end

  it 'allows a row of url information to be displayed based on given id' do
    @repo.create({:original_url => "http://www.google.com", :new_url => "http://localhost:9292/1"})
    @repo.create({:original_url => "http://www.facebook.com", :new_url => "http://localhost:9292/2"})
    expect(@repo.find(1)).to eq ({:id => 1, :original_url => "http://www.google.com", :new_url => "http://localhost:9292/1"})
  end

end
