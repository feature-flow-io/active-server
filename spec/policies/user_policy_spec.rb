require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, record) }

  context "when being a guest" do
    let(:user) { nil }
    let(:record) { create(:user) }

    it "raises an error" do
      expect do
        subject # rubocop:disable RSpec/NamedSubject
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context "when being the current user" do
    let(:user) { create(:user) }
    let(:record) { user }

    it { is_expected.to permit_actions(%i[show]) }
  end

  context "when not being the current user and without being in the same account" do
    let(:user) { create(:user) }
    let(:record) { create(:user) }

    it { is_expected.to forbid_actions(%i[show]) }
  end

  describe "in the same account" do
    let(:account) { create(:account) }
    let(:another_collaborator) { create(:collaborator, account: account) }
    let(:record) { another_collaborator.user }

    context "when not being the current user but with permanent collaboration" do
      let(:collaborator) { create(:collaborator, account: account) }
      let(:user) { collaborator.user }

      it { is_expected.to permit_actions(%i[show]) }
    end

    context "when not being the current user but without permanent collaboration" do
      let(:collaborator) { create(:collaborator, :pending, account: account) }
      let(:user) { collaborator.user }

      it { is_expected.to forbid_actions(%i[show]) }
    end
  end
end
