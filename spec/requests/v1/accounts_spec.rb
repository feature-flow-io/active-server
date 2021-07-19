require "rails_helper"

RSpec.describe "V1::Accounts", type: :request do
  let(:user) { create(:user) }
  let(:attribute_array) { %i[name subdomain cname status updated_at created_at] }

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

      it "creates a new collaborator record for the current user" do
        Timecop.freeze(Time.zone.today) do
          post v1_accounts_path, params: valid_attributes, headers: authorized_header(user)

          collaborator = user.collaborators.first
          expect(collaborator.account).to eq(Account.first)
          expect(collaborator.role).to eq("owner")
          expect(collaborator.joined_at).to eq(Time.zone.now)
        end
      end

      it "returns the attributes" do
        post v1_accounts_path, params: valid_attributes, headers: authorized_header(user)

        expect(attribute_keys).to match_array(attribute_array)
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

  describe "#show" do
    it "returns the account" do
      account = create(:account)
      create(:collaborator, user: user, account: account)
      get v1_account_path(account), headers: authorized_header(user)

      expect(attribute_keys).to match_array(attribute_array)
    end
  end

  describe "#updated_at" do
    let(:account) { create(:account) }

    before do
      create(:collaborator, :owner, user: user, account: account)
    end

    context "when the request is valid" do
      let(:valid_attributes) { { data: { attributes: { name: "New name", cname: "name.abeid.com", status: "inactive" } } }.to_json }

      it "updates the account" do
        patch v1_account_path(account), params: valid_attributes, headers: authorized_header(user)

        account.reload
        expect(account.name).to eq("New name")
        expect(account.cname).to eq("name.abeid.com")
        expect(account.status).to eq("inactive")
      end

      it "returns the attributes" do
        patch v1_account_path(account), params: valid_attributes, headers: authorized_header(user)

        expect(attribute_keys).to match_array(attribute_array)
        expect(relationship_keys).to match_array(%i[creator])
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) { { data: { attributes: { name: "", cname: "name.abeid.com" } } }.to_json }

      it "returns an error" do
        patch v1_account_path(account), params: invalid_attributes, headers: authorized_header(user)

        expect(response_errors).to match_array(%i[name])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
