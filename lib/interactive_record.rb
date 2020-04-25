require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    # sql = "PRAGMA t_info('#{table_name}');"

    t_info = DB[:conn].execute("PRAGMA t_info('#{table_name}')")
    column_names = []

    t_info.each do |col|
      column_names << col["name"]
    end
    column_names.compact
  end

  def initialize(choice={})
    choice.each {|property, value| self.send("#{property}=", value)}
  end

  def col_names_for_insert
    self.class.column_names.delete_if {|col| col == "id"}.join(", ")
  end
end
