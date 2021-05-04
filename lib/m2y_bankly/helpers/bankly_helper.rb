require 'json'

module M2yBankly
  class BanklyHelper

    def self.homologation?(env)
      env == HOMOLOGATION
    end

    def self.saveToken(basic,token)
      if !token.nil?
        ENV["BKLY_TOKEN"] = token.to_s
        ENV["BKLY_TOKEN_EXPIRY"] = (Time.now + 1500).to_s
      end
    end

    def self.should_refresh_token?(basic)
      finish_date = ENV["BKLY_TOKEN_EXPIRY"]
      finish_date.nil? || (Time.parse(finish_date.to_s) - 500) < Time.now
    end


    def self.bankly_body_to_string(json)
      string = "?"
      arr = []
      json.keys.each do |key|
        if !json[key].nil?
          arr << key.to_s + "=" + json[key].to_s
        end
      end
      string + arr.join("&")
    end

    def self.generate_general_response(req)
      if req
        {
          success: req[:statusCode] >= 400 ? false : true,
          content: req
        }
      else
        req
      end
    end

    def self.json_to_url_params(json)
      string = '?'
      arr = []
      json.keys.each do |key|
        if !json[key].nil?
          arr << key.to_s + '=' + json[key].to_s
        end
      end
      string + arr.join('&')
    end

  end
end
