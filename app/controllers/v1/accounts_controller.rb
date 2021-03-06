module V1
  class AccountsController < ApplicationController
    def create
      account = Account.new(new_account_params)
      authorize account
      account.creator = Current.user

      if account.save
        account.collaborators.create!(role: "owner", joined_at: Time.zone.now, user: Current.user)
        render json: account, status: :created
      else
        render json: ErrorSerializer.serialize(account.errors), status: :unprocessable_entity
      end
    end

    def show
      account = Account.find(params[:id])
      authorize account
      render json: account
    end

    def update
      account = Account.find(params[:id])
      authorize account

      if account.update(edit_account_params)
        render json: account
      else
        render json: ErrorSerializer.serialize(account.errors), status: :unprocessable_entity
      end
    end

    private

    def new_account_params
      jsonapi_params(only: %i[name subdomain])
    end

    def edit_account_params
      jsonapi_params(only: %i[name cname status])
    end
  end
end
