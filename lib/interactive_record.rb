require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    sql = "PRAGMA t_info('#{table_name}');"

    t_info = DB[:conn].execute(sql)
    column_names = []

    t_info.each do |col|
      column_names << col["name"]
    end
    column_names.compact
  end
end
