module ErrorEnum
    UnknownError = 0
    InputError = 1
    NotFound = 2
    BadRequest = 3
end

module BanklyMappedErrors
    InputError = "MethodArgumentNotValidException"
    NotFoundPIER = "NotFoundExceptionPIER"
    BadRequestPIER = "BadRequestExceptionPIER"
end

module M2yBankly
    class BanklyErrorHandler
        attr_accessor :errorType, :message, :reasons, :status, :banklyStatus

        def initialize()
            @errorType = nil
            @message = ""
            @reasons = []
            @status = 400
            @banklyStatus = 0
        end

        def to_json()
            json = {
                errorType: @errorType,
                message: @message,
                reasons: @reasons,
                status: @status,
                banklyStatus: @banklyStatus
            }
            json
        end

        def mapErrorType(banklyResponse)
            @message = ""
            @errorType = nil
            hasError = false
            
            if banklyResponse.class == Hash
                if !banklyResponse['exception'].nil?
                    hasError = true
                    @message = banklyResponse['exception']
                    case banklyResponse['exception']
                    when BanklyMappedErrors::InputError
                        @errorType = ErrorEnum::InputError
                        @status = 422
                    when BanklyMappedErrors::NotFoundPIER
                        @errorType = ErrorEnum::NotFound
                        @status = 404
                    when BanklyMappedErrors::BadRequestPIER
                        @errorType = ErrorEnum::BadRequest
                        @status = 400
                    else
                        @errorType = ErrorEnum::UnknownError
                    end
                    if !banklyResponse[:code].nil?
                        @banklyStatus = banklyResponse[:code]
                    elsif !banklyResponse[:status].nil?
                        @banklyStatus = banklyResponse[:status]
                    end
                    generateReasons(banklyResponse)
                elsif !banklyResponse[:message].nil? and !banklyResponse[:message].downcase.include? "success"
                    hasError = true
                    @message = banklyResponse[:message]
                elsif !banklyResponse[:error].nil?
                    hasError = true
                    @message = banklyResponse[:message]
                    generateReasons(banklyResponse)
                    @errorType = ErrorEnum::UnknownError
                end
            end
            hasError
        end

        def generateReasons(banklyResponse)
            @reasons = []
            if !banklyResponse[:erros].nil?
                banklyResponse[:erros].each do |error|
                    reasonMessage = ""
                    if !error["field"].nil?
                        reasonMessage += error["field"]
                    end
                    if !error["defaultMessage"].nil?
                        reasonMessage += " " + error["defaultMessage"]
                    end
                    # puts error["code"]
                    reason = { message: reasonMessage, banklyCode: error["code"] }
                    @reasons << reason
                end
            elsif !banklyResponse[:message].nil?
                @reasons << banklyResponse[:message]
            elsif !banklyResponse[:error].nil?
                @reasons << banklyResponse[:error]
            end
        end
    end
end



