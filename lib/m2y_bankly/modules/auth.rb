module M2yBankly

  class Auth

    def initialize(client_id, client_secret, env)
      @request = BanklyRequest.new("Basic ", client_id)
      @client_id = client_id
      @client_secret = client_secret
      @url = BanklyHelper.homologation?(env) ? TOKEN_HML : TOKEN_PRD
    end

    def generate_token
      puts @url
      data = {
        client_id: @client_id,
        client_secret: @client_secret,
        grant_type: GRANT_TYPE
      }


      response = HTTParty.post(@url + TOKEN_PATH,
                               body: URI.encode_www_form(data),
                               headers: {
                                 'Content-Type' => 'application/x-www-form-urlencoded'
                               }
                               )

      puts response

      if response.code == 200
        BanklyHelper.saveToken(@client_id, response.parsed_response["access_token"])
      end
    end


  end
end
