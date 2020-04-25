require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results= true

    sql = "PRAGMA t_info('#{table_name}')"

    t_info = DB[:conn].execute(sql)
    col_name = []

    t_info.each do |col|
      col_name << col["name"]
    end
    col_name.compact
  end
end
