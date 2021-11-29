module M2yBankly
  
  #envs
  HOMOLOGATION = "hml"
  PRODUCTION = "prd"
  GRANT_TYPE= "client_credentials"

  #urls
  URL_HML = "https://api.sandbox.bankly.com.br"
  URL_PRD = "https://api.bankly.com.br"

  #auth_url
  TOKEN_HML = "https://login.sandbox.bankly.com.br/"
  TOKEN_PRD = "https://login.bankly.com.br/"

  TOKEN_PATH = 'connect/token'

  # Account
  CUSTOMERS = 'customers'
  BUSINESS = 'business'
  DOCUMENT = 'document-analysis'
  ACCOUNTS = 'accounts'
  ACCOUNT = 'account'
  STATEMENT = 'statement'
  EVENTS = 'events'
  BRANCH = 'branch'
  NUMBER = 'number'

  # Cards
  CARDS = 'cards'
  PHYSICAL = 'physical'
  VIRTUAL = 'virtual'
  ACTIVATE = 'activate'
  PCI = 'pci'
  CONTACTLESS = 'contactless'
  PASSWORD = 'password'
  STATUS = 'status'
  TRANSACTIONS = 'transactions'

  # Payment
  PAYMENT = 'bill-payment'
  VALIDATE = 'validate'
  CONFIRM = 'confirm'
  DETAIL = 'detail'

  # Transfer
  BANKLIST = 'banklist'
  TRANSFER = 'fund-transfers'
  CANCEL = 'cancel'

  # Bank Slip
  BANKSLIP = 'bankslip'
  PDF = 'pdf'
  SEARCH = "searchstatus"
end
