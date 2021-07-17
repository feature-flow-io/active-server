module V1
  class AccountsController < ApplicationController
    def create
      account = Account.new(account_params)
      account.creator = Current.user

      if account.save
        render json: account, status: :created
      else
        render json: ErrorSerializer.serialize(account.errors), status: :unprocessable_entity
      end
    end

    def show
      account = Account.find(params[:id])
      render json: account
    end

    private

    def account_params
      jsonapi_params(only: %i[name subdomain])
    end
  end
end
