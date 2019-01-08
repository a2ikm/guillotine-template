require "bundler"
Bundler.require

class App < Guillotine::App
  db = Sequel.connect(ENV["DATABASE_URL"])
  db.run <<-SQL
    CREATE TABLE IF NOT EXISTS `urls` (
      `url` varchar(255) DEFAULT NULL,
      `code` varchar(255) DEFAULT NULL,
      UNIQUE KEY `url` (`url`),
      UNIQUE KEY `code` (`code`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  SQL

  adapter = Guillotine::Adapters::SequelAdapter.new(db)
  set service: Guillotine::Service.new(adapter)
end
