if defined? JRUBY_VERSION
  require 'activerecord-jdbcpostgresql-adapter'
  error_classes = [ActiveRecord::JDBCError]
else
  require "pg"
  error_classes = [PGError]
end

error_classes << ActiveRecord::NoDatabaseError if defined? ActiveRecord::NoDatabaseError

begin
  database_user = if ENV["TRAVIS"]
                    "postgres"
                  else
                    ENV["USER"]
                  end

  ActiveRecord::Base.establish_connection(:adapter  => 'postgresql',
                                          :database => 'pg_search_test',
                                          :username => database_user,
                                          :min_messages => 'warning')
  connection = ActiveRecord::Base.connection
  postgresql_version = connection.send(:postgresql_version)
  connection.execute("SELECT 1")
rescue *error_classes
  at_exit do
    puts "-" * 80
    puts "Unable to connect to database.  Please run:"
    puts
    puts "    createdb pg_search_test"
    puts "-" * 80
  end
  raise $!
end

if ENV["LOGGER"]
  require "logger"
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
