module M2yBankly

  class Account < BanklyModule

    def initialize(client_id, client_secret, env)
      startModule(client_id, client_secret, env)
    end

    def create_person(document_number, body)
      response = @request.put("#{@url}/#{CUSTOMERS}/#{document_number.gsub(/[^0-9]/, '')}", body)
      person = BanklyModel.new(response)
      person
    end

    def update_person(document_number, body)
      response = @request.patch("#{@url}/#{CUSTOMERS}/#{document_number.gsub(/[^0-9]/, '')}", body)
      person = BanklyModel.new(response)
      person
    end

    def get_person(document_number)
      response = @request.get("#{@url}/#{CUSTOMERS}/#{document_number.gsub(/[^0-9]/, '')}?resultLevel=DETAILED")
      person = BanklyModel.new(response)
      person
    end

    def get_company(document_number)
      response = @request.get("#{@url}/#{BUSINESS}/#{document_number.gsub(/[^0-9]/, '')}?resultLevel=DETAILED")
      person = BanklyModel.new(response)
      person
    end

    def send_document(document_number, opts)
      opts[:headers] = {
        'Accept' => 'application/json',
        'api-version' => '1.0'
      }
      response = @request.putBinary("#{@url}/#{DOCUMENT}/#{document_number.gsub(/[^0-9]/, '')}", opts)
      document = BanklyModel.new(response)
      document
    end

    def get_files_statuses(document_number, file_tokens)
      response = @request.get("#{@url}/#{DOCUMENT}/#{document_number.gsub(/[^0-9]/, '')}?resultLevel=DETAILED&#{file_tokens}", true)
    end

    def create_bank_account(document_number, account_type = 'PAYMENT_ACCOUNT')
      response = @request.postWithHeader("#{@url}/#{CUSTOMERS}/#{document_number.gsub(/[^0-9]/, '')}/#{ACCOUNTS}", { accountType: account_type })
      account = BanklyModel.new(response)
      account
    end

    def get_bank_account(document_number)
      response = @request.get("#{@url}/#{CUSTOMERS}/#{document_number.gsub(/[^0-9]/, '')}/#{ACCOUNTS}", true)
    end

    def get_account_status(account_number)
      response = @request.get("#{@url}/#{ACCOUNTS}/#{account_number.gsub(/[^0-9]/, '')}", true)
    end

    def get_account_balance(bank_number)
      response = @request.get("#{@url}/#{ACCOUNTS}/#{bank_number.gsub(/[^0-9]/, '')}?includeBalance=true", true)
    end

    def get_account_statements(bank_agency, bank_number, offset, limit = 20, details = 'true')
      response = @request.get("#{@url}/#{ACCOUNT}/#{STATEMENT}?branch=#{bank_agency}&account=#{bank_number}&offset=#{offset}&limit=#{limit}&details=#{details}"
                              )
    end

    def get_account_events(bank_agency, bank_number, beginDateTime, endDateTime, limit = 20, details = 'true')
      response = @request.get("#{@url}/#{EVENTS}?branch=#{bank_agency}&account=#{bank_number}&endDateTime=#{endDateTime}&beginDateTime=#{beginDateTime}&pageSize=#{limit}&includeDetails=#{details}"
                              )
    end

  end
end
