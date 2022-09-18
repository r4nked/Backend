require 'rails_helper'

RSpec.describe Stack do
  describe '#card_names' do
    it "generates cards from the list of names" do
      stack = build(:stack, card_names: %w[one two three].join("\n"))
      stack.save!
      expect(stack.cards.pluck(:name)).to match_array(%w[one two three])
    end

    it "skips blank lines and strip lines" do
      stack = build(:stack, card_names: "one \n\n  \n two")
      stack.save!
      expect(stack.cards.pluck(:name)).to match_array(%w[one two])
    end
  end

  describe '#to_param' do
    let(:stack) { build :stack, id: 12345 }

    it "returns the encoded ID" do
      expect(stack.to_param).to eql('9ix')
    end
  end

  describe '#find_by_hash!' do
    let(:stack) { create :stack }

    it "finds a stack by encoded ID" do
      expect(described_class.find_by_hash!(stack.to_param)).to eql(stack) # rubocop:disable Rails/DynamicFindBy
    end
  end

  describe '#pairs_order' do
    let(:stack) { create :stack, card_names: [1, 2, 3, 4].map(&:to_s).join("\n") }

    it "is automatically set to a random ordering of all possible pairs" do
      expect(stack.pairs_order).to match_array([[0, 1], [0, 2], [0, 3], [1, 2], [1, 3], [2, 3]])
    end
  end

  describe '#rank' do
    it "returns Elo rankings given an ordered array of match results" do
      stack   = create(:stack, card_names: (1..9).to_a.join("\n"))
      matches = stack.pairs_order.map do |(first, second)|
        first  = stack.cards.order(id: :asc)[first].name.to_i
        second = stack.cards.order(id: :asc)[second].name.to_i
        if first > second
          :first
        elsif second > first
          :second
        else
          :both
        end
      end

      expect(stack.rank(matches).map(&:first).map(&:name)).to eql(stack.cards.order(name: :desc).pluck(:name))
    end
  end

  context '[validations]' do
    it "requires at least 2 cards" do
      stack = build(:stack, card_names: "foo")
      expect(stack).not_to be_valid
      expect(stack.errors.details[:cards]).to eql([{error: :too_few}])

      stack = build(:stack, card_names: "foo\nbar")
      expect(stack).to be_valid
    end
  end
end
