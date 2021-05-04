module M2yBankly

  class BankSlip < BanklyModule

    def initialize(client_id, client_secret, env)
      startModule(client_id, client_secret, env)
    end

    def generate(body)
      response = @request.postWithHeader("#{@url}/#{BANKSLIP}", body)
      BanklyModel.new(response)
    end

    def get_slip_data(branch, account, authentication_code)
      @request.get("#{@url}/#{BANKSLIP}/#{BRANCH}/#{branch}/#{NUMBER}/#{account}/#{authentication_code}", true)
    end

    def receipts(date)
      @request.get("#{@url}/#{BANKSLIP}/#{SEARCH}/#{date}", true)
    end

    def get_slip_pdf(authentication_code)
      @request.get("#{@url}/#{BANKSLIP}/#{authentication_code}/#{PDF}", true)
    end

    def cancel_slip(branch, account, authentication_code)
      response = @request.delete("#{@url}/#{BANKSLIP}/#{CANCEL}", { authenticationCode: authentication_code, account: { number: account, branch: branch } })
      BanklyModel.new(response)
    end

  end
end
