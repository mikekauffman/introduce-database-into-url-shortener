require 'pg'
require 'sequel'

class URLdb

  def initialize(database)
    @database_table = database[:urls]
  end

  def create(attributes)
    @database_table.insert(attributes)
  end

  def all
    @database_table.to_a
  end

  def find_by(id)
    @database_table.where(:id => id)
  end

  def update(id, attribute_hash)
    find_by(id).update(attribute_hash)
  end

  def find(id)
    find_by(id).to_a[0]
  end

  def delete(id)
    find_by(id).delete
  end

end