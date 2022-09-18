require 'rails_helper'

RSpec.describe '/stacks' do
  describe '#show' do
    let(:stack) { create :stack }

    it "renders the JSON for a stack" do
      get "/stacks/#{stack.to_param}.json"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['name']).to eql(stack.name)
      stack.cards.order(id: :asc).each_with_index do |card, index|
        expect(json['cards'][index]['name']).to eql(card.name)
      end
    end

    it "includes rankings if matches are given" do
      matches         = Array.new(stack.pairs_order.size) { %i[first second both].sample }
      encoded_matches = matches.map { |m| StacksController.const_get(:MATCH_TYPES).index(m) }.
          join.to_i(4).to_fs(36)
      get "/stacks/#{stack.to_param}.json?m=#{encoded_matches}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['rankings']).to be_a(Array)
      results = stack.rank(matches)
      expect(json['rankings']).to eql(results.map { |r| {'name' => r.first.name, 'ranking' => r.last} })
    end
  end

  describe '#create' do
    it "creates a new stack with cards" do
      post '/stacks.json', params: {stack: {name: "My Stack", card_names: "one\ntwo\nthree"}}
      expect(response).to have_http_status(:created)
      expect(Stack.count).to be(1)
      stack = Stack.first
      expect(stack.name).to eql("My Stack")
      expect(stack.cards.count).to be(3)
      expect(stack.cards.pluck(:name)).to match_array(%w[one two three])
    end

    it "handles validation errors" do
      post '/stacks.json', params: {stack: {name: " ", card_names: "one\ntwo\nthree"}}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eql('{"errors":{"name":[{"error":"blank"}]}}')
    end

    it "handles validation errors on a card" do
      post '/stacks.json', params: {stack: {name: "My Stack", card_names: ['one', 'two'*100, 'three'].join("\n")}}
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']['cards'].first['error']).to eql('invalid')
    end
  end
end
