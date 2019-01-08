require "bundler"
Bundler.require

class App < Guillotine::App
  db = Sequel.connect(ENV["DATABASE_URL"])
  db.create_table?(:urls) do
    column :url, String, unique: true
    column :code, String, unique: true
  end

  adapter = Guillotine::Adapters::SequelAdapter.new(db)
  set service: Guillotine::Service.new(adapter)
end
