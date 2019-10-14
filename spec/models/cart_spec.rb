# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  fixtures(:users)

  context "validations" do
    it { is_expected.to have_many(:loans) }
    it { is_expected.to validate_presence_of(:volunteer) }
    it { is_expected.to belong_to(:volunteer) }
    it { is_expected.to validate_presence_of(:member) }
    it { is_expected.to belong_to(:member) }
  end

  describe '#line_items' do
    fixtures(:carriers)

    let(:member)    { users(:user) }
    let(:volunteer) { users(:volunteer) }

    let(:carrier)  { carriers(:carrier) }
    let(:due_date) { Date.today + 1.days }

    subject { described_class.create!(member: member, volunteer: volunteer) }

    context "with a single loan" do
      let(:loan) { subject.loans.create!(carrier: carrier, due_date: due_date) }

      it 'returns an array containing the loan' do
        expect(subject.line_items).to eq [loan]
      end
    end
  end
end
