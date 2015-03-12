module Polychallenge
  
  # load the yml file with the ebay credentials
  EBAY_CREDENTIALS = YAML::load_file(File.join(File.dirname(__FILE__), "yaml/ebay.yml"))
  
  # Call the EbayApi to get the category tree
  #
  class EbayApi
    def self.apicall
      requestXml = "<?xml version='1.0' encoding='utf-8'?>
                    <GetCategoriesRequest xmlns='urn:ebay:apis:eBLBaseComponents'>
                      <RequesterCredentials>
                        <eBayAuthToken>#{auth_token}</eBayAuthToken>
                      </RequesterCredentials>
                      <DetailLevel>ReturnAll</DetailLevel>
                    </GetCategoriesRequest>"

      response = HTTParty.post(api_url, :body => requestXml, :headers => ebay_headers)
      response.parsed_response['GetCategoriesResponse']['CategoryArray']['Category']
    end

    def self.ebay_headers
      {"X-EBAY-API-CALL-NAME" => "GetCategories",
       "X-EBAY-API-COMPATIBILITY-LEVEL" => "861",
       "X-EBAY-API-DEV-NAME" => EBAY_CREDENTIALS['X-EBAY-API-DEV-NAME'],
       "X-EBAY-API-APP-NAME" => EBAY_CREDENTIALS['X-EBAY-API-APP-NAME'],
       "X-EBAY-API-CERT-NAME" => EBAY_CREDENTIALS['X-EBAY-API-CERT-NAME'],
       "X-EBAY-API-SITEID" => "0",
       "Content-Type" => "text/xml"}
    end

    def self.auth_token
      EBAY_CREDENTIALS['AUTH_TOKEN']
    end

    def self.api_url
      "https://api.sandbox.ebay.com/ws/api.dll"
    end
  end
end