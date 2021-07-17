require "rails_helper"

RSpec.describe AccountPolicy, type: :policy do
  subject { described_class.new(user, account) }

  context "when being a guest" do
    let(:user) { nil }
    let(:account) { Account.new }

    it "raises an error" do
      expect do
        subject # rubocop:disable RSpec/NamedSubject
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context "when being a logged in user" do
    let(:user) { create(:user) }
    let(:account) { Account.new }

    it { is_expected.to permit_actions(%i[create]) }
  end

  context "when being an owner" do
    let(:collaborator) { create(:collaborator, :owner) }
    let(:user) { collaborator.user }
    let(:account) { collaborator.account }

    it { is_expected.to permit_actions(%i[show]) }
  end

  context "when being an editor" do
    let(:collaborator) { create(:collaborator) }
    let(:user) { collaborator.user }
    let(:account) { collaborator.account }

    it { is_expected.to permit_actions(%i[show]) }
  end

  context "when being a pending collaborator" do
    let(:collaborator) { create(:collaborator, :pending, :owner) }
    let(:user) { collaborator.user }
    let(:account) { collaborator.account }

    it { is_expected.to forbid_actions(%i[show]) }
  end
end
