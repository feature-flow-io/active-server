require "rails_helper"

RSpec.describe "V1::Accounts", type: :request do
  let(:user) { create(:user) }

  describe "#create" do
    context "when the request is valid" do
      let(:valid_attributes) { { data: { attributes: { name: "Example account", subdomain: "mysub" } } }.to_json }

      it "creates an account" do
        expect do
          post v1_accounts_path, params: valid_attributes, headers: authorized_header(user)
        end.to change(Account, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it "assigns the current user as the account creator" do
        post v1_accounts_path, params: valid_attributes, headers: authorized_header(user)

        expect(Account.first.creator).to eq(user)
      end

      it "returns the attributes" do
        post v1_accounts_path, params: valid_attributes, headers: authorized_header(user)

        expect(attribute_keys).to match_array(%i[name subdomain cname updated_at created_at])
        expect(relationship_keys).to match_array(%i[creator])
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) { { data: { attributes: { name: "Example account", subdomain: "" } } }.to_json }

      it "does not create an account" do
        expect do
          post v1_accounts_path, params: invalid_attributes, headers: authorized_header(user)
        end.not_to change(Account, :count)
      end

      it "returns an error" do
        post v1_accounts_path, params: invalid_attributes, headers: authorized_header(user)

        expect(response_errors).to match_array(%i[subdomain])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
