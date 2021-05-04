module M2yBankly

  class Transfer < BanklyModule

    def initialize(client_id, client_secret, env)
      startModule(client_id, client_secret, env)
    end

    def list_banks
      response = @request.get("#{@url}/#{BANKLIST}")
    end

    def execute(body)
      response = @request.postWithHeader("#{@url}/#{TRANSFER}", body)
      BanklyModel.new(response)
    end

    def receipt(agency, account, authentication_code)
      response = @request.get("#{@url}/#{TRANSFER}/#{authentication_code}?branch=#{agency}&account=#{account}")
    end

  end
end
