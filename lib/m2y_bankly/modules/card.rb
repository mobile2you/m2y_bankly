module M2yBankly

  class Card < BanklyModule

    def initialize(client_id, client_secret, env)
      startModule(client_id, client_secret, env)
    end

    def get_account_cards(account, agency, document)
      @request.get("#{@url}/#{CARDS}/#{ACCOUNT}/#{account}?agency=#{agency}&documentNumber=#{document}")
    end

    def request_card(body)
      response = @request.postWithHeader("#{@url}/#{CARDS}/#{PHYSICAL}", body)
      card = BanklyModel.new(response)
      card
    end

    def request_virtual_card(body)
      response = @request.postWithHeader("#{@url}/#{CARDS}/#{VIRTUAL}", body)
      card = BanklyModel.new(response)
      card
    end

    def get_card(proxy)
      response = @request.get("#{@url}/#{CARDS}/#{proxy}")
    end

    def get_virtual_card(proxy, password)
      response = @request.postWithHeader("#{@url}/#{CARDS}/#{proxy}/#{PCI}", { password: password })
      card = BanklyModel.new(response)
      card
    end

    def activate_card(proxy, body)
      response = @request.patchWithHeader("#{@url}/#{CARDS}/#{proxy}/#{ACTIVATE}", body)
      card = BanklyModel.new(response)
      card
    end

    def validate_password(proxy, password)
      response = @request.postWithHeader("#{@url}/#{CARDS}/#{proxy}/#{PCI}", { password: password })
      card = BanklyModel.new(response)
      card
    end

    def update_contactless_config(proxy, boolean)
      response = @request.patchWithHeader("#{@url}/#{CARDS}/#{proxy}/#{CONTACTLESS}?allowContactless=#{boolean}", {})
      card = BanklyModel.new(response)
      card
    end
    
    def update_card_password(proxy, new_password)
      response = @request.patchWithHeader("#{@url}/#{CARDS}/#{proxy}/#{PASSWORD}", { password: new_password })
      card = BanklyModel.new(response)
      card
    end

    def update_card_status(proxy, status, password, update_card_binded = false)
      response = @request.patchWithHeader("#{@url}/#{CARDS}/#{proxy}/#{STATUS}", { status: status, password: password, updateCardBinded: update_card_binded })
      card = BanklyModel.new(response)
      card
    end


  end
end
