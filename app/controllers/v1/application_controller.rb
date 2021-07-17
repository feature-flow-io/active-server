module V1
  class ApplicationController < ::ApplicationController
    include ActionController::MimeResponds
    include SetCurrentUserDetails
    include Authenticable

    private

    def jsonapi_params(only:)
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: only)
    end
  end
end
