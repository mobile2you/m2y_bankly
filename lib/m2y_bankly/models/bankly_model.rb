require "json"
require "ostruct"

class BanklyModel < OpenStruct

  def as_json(options = nil)
    @table.as_json(options)
  end

end