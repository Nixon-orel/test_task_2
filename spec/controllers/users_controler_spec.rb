# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe 'POST /users' do
    subject(:post_users) { post :create, params: params }

    before do
      allow(Users::Create)
        .to receive(:run)
        .with(params)
        .and_return(
          result
        )
    end

    let(:params) do
      { 'name' => Faker::FunnyName.name,
        'surname' => Faker::Lorem.word,
        'patronymic' => Faker::Lorem.word,
        'email' => Faker::Internet.email,
        'gender' => %w[male female].sample,
        'nationality' => Faker::Lorem.word,
        'country' => Faker::Address.country,
        'age' => rand(0..90).to_s,
        'interests' => [ 'interest' ],
        'skills' => [ 'skill' ] }
    end

    context 'when users::Create returns success object' do
      let(:id) { rand(1..10) }
      let(:result) { instance_double(Users::Create, result: instance_double(User, id: id)) }

      it 'returns id' do
        post_users
        expect(JSON.parse(response.body)).to eq({ 'user' => id })
      end
    end

    context 'when users::Create returns failed result' do
      let(:result) { instance_double(Users::Create, result: nil) }

      it 'returns id' do
        post_users
        expect(response.status).to eq(422)
      end
    end
  end
end
