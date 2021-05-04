module M2yBankly

  class BanklyModule

    def startModule(client_id, client_secret, env)
      @auth = Auth.new(client_id, client_secret, env)
      @client_id = client_id
      @client_secret = client_secret
      refresh_token
      @request = BanklyRequest.new(nil, @client_id)
      @url = BanklyHelper.homologation?(env) ? URL_HML : URL_PRD
    end

    def refresh_token
      if BanklyHelper.should_refresh_token?(@client_id)
        @auth.generate_token
        @request = BanklyRequest.new(nil, @client_id)
      end
    end

    def generateResponse(input)
      BanklyHelper.generate_general_response(input)
    end


  end

end
