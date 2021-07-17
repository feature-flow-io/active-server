require "rails_helper"

RSpec.describe "V1::Users", type: :request do
  let(:valid_attributes) { { data: { attributes: { name: "John Doe", email: "john@example.com", password: "secretpass" } } } }
  let(:invalid_attributes) { { data: { attributes: { name: "John Doe", email: "john@example.com", password: "" } } } }

  describe "#create" do
    context "when the request is valid" do
      it "creates the user" do
        expect do
          post v1_users_path, params: valid_attributes
        end.to change(User, :count).by(1)
      end

      it "sends the response" do
        post v1_users_path, params: valid_attributes

        expect(attribute_keys).to match_array(%i[name email token updated_at created_at])
        expect(response).to have_http_status(:created)
      end
    end

    context "when the request is invalid" do
      it "does not create the user" do
        expect do
          post v1_users_path, params: invalid_attributes
        end.not_to change(User, :count)
      end

      it "returns an error" do
        post v1_users_path, params: invalid_attributes

        expect(response_errors).to match_array(%i[password])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
