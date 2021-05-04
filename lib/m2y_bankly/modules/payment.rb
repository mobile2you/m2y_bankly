module M2yBankly

  class Payment < BanklyModule

    def initialize(client_id, client_secret, env)
      startModule(client_id, client_secret, env)
    end

    def validate(barcode)
      response = @request.postWithHeader("#{@url}/#{PAYMENT}/#{VALIDATE}", { code: barcode })
      BanklyModel.new(response)
    end

    def pay(id, agency, account, amount, desc = '')
      response = @request.postWithHeader("#{@url}/#{PAYMENT}/#{CONFIRM}", { id: id, bankBranch: agency, bankAccount: account, amount: amount, description: desc })
      BanklyModel.new(response)
    end

    def receipts(agency, account)
      response = @request.get("#{@url}/#{PAYMENT}?branch=#{agency}&account=#{account}")
    end

    def receipt(agency, account, authentication_code)
      response = @request.get("#{@url}/#{PAYMENT}/#{DETAIL}?authentication_code=#{authentication_code}&branch=#{agency}&account=#{account}")
    end


  end
end
