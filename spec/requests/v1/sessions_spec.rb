require "rails_helper"

RSpec.describe "V1::Sessions", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { data: { attributes: { email: user.email, password: user.password } } } }
  let(:invalid_attributes) { { data: { attributes: { email: "invalid@example.com", password: user.password } } } }

  describe "#create" do
    context "when the request is valid" do
      it "returns the user attributes" do
        post v1_sessions_path, params: valid_attributes

        expect(attribute_keys).to match_array(%i[name email auth_token])
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the request is invalid" do
      it "returns an error" do
        post v1_sessions_path, params: invalid_attributes

        expect(response_errors).to match_array(%i[invalid])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
