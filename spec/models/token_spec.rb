require "rails_helper"

RSpec.describe Token do
  it "encodes the hash passed" do
    user = { id: 1 }
    token = described_class.encode(user)

    expect(token).not_to eq(user)
  end

  it "decodes the hash passed" do
    user = { id: 1 }
    token = described_class.encode(user)

    expect(described_class.decode(token)["id"]).to eq(user[:id])
  end
end
