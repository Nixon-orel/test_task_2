# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create do
  let(:params) do
    { 'name' => name,
      'surname' => surname,
      'patronymic' => patronymic,
      'email' => email,
      'gender' => gender,
      'nationality' => nationality,
      'country' => country,
      'age' => age.to_s,
      'interests' => interests,
      'skills' => skills }
  end
  let(:name) { Faker::FunnyName.name }
  let(:surname) { Faker::Lorem.word }
  let(:patronymic) { Faker::Lorem.word }
  let(:email) { Faker::Internet.email }
  let(:gender) { %w[male female].sample }
  let(:nationality) { Faker::Lorem.word }
  let(:country) { Faker::Address.country }
  let(:age) { rand(0..90) }
  let(:interests) { [ 'interest' ] }
  let(:skills) { [ 'skill' ] }

  before do
    create(:skill, name: 'skill')
    create(:interest, name: 'interest')
  end

  describe 'validations' do
    subject(:run) { described_class.run(params: sent_params) }

    context 'when all expected params present' do
      let(:sent_params) { params }

      it 'returns result' do
        expect(run.result).to be_kind_of(User)
      end
    end

    context 'when one expected attribute is missing' do
      let(:sent_params) do
        params.except(
          %w[name surname patronymic email gender nationality country age interest skills].sample
        )
      end

      it 'returns nil result' do
        expect(run.result).to be_nil
      end

      it 'returns object with errors' do
        expect(run.errors).not_to eq([])
      end
    end
  end

  describe '#execute' do
    subject(:run) { described_class.run(params: params) }

    context 'when age not valid' do
      before do
        params['age'] = [ -5, -1, 91, 105 ].sample
      end

      it 'returns nil result' do
        expect(run.result).to be_nil
      end
    end

    context 'when gender not valid' do
      before do
        params['gender'] = %w[women men child].sample
      end

      it 'returns nil result' do
        expect(run.result).to be_nil
      end
    end

    context 'when user with sent email present' do
      let(:email) { Faker::Internet.email }
      let!(:user) { create :user, email: email }

      before do
        params['email'] = email
      end

      it 'returns nil result' do
        expect(run.result).to be_nil
      end
    end

    context 'when params valid' do
      let(:interests) { %w[interest_1 interest_2] }
      let(:skills) { %w[skill_1 skill_2 skill_3] }
      let!(:interest_1) { create :interest, name: 'interest_1' }
      let!(:interest_2) { create :interest, name: 'interest_2' }
      let!(:skill_1) { create :skill, name: 'skill_1' }
      let!(:skill_2) { create :skill, name: 'skill_2' }
      let!(:skill_3) { create :skill, name: 'skill_3' }

      it 'return expected user' do
        expect(run.result).to have_attributes name: name,
                                              surname: surname,
                                              patronymic: patronymic,
                                              email: email,
                                              gender: gender,
                                              nationality: nationality,
                                              country: country,
                                              age: age
      end

      it 'user has expected associations' do
        run
        expect(User.last.skills).to eq([ skill_1, skill_2, skill_3 ])
        expect(User.last.interests).to eq([ interest_1, interest_2 ])
      end
    end
  end
end
