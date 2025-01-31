# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    GENDERS = %w[male female]

    hash :params do
      string  :name
      string  :patronymic
      string  :surname
      string  :email
      string  :gender
      string  :nationality
      string  :country
      integer :age
      array   :interests
      array   :skills
    end

    def execute
      return if params_invalid?

      user_full_name = "#{params['surname']} #{params['name']} #{params['patronymic']}"
      params['interests'].map! { |interest| Interest.find_by(name: interest) }.compact!
      params['skills'].map! { |skill| Skill.find_by(name: skill) }.compact!
      User.create!(params.merge(full_name: user_full_name))
    end

    private

    def params_invalid?
      gender_valid? || age_valid? || user_already_present?
    end

    def gender_valid?
      GENDERS.exclude? params["gender"]
    end

    def age_valid?
      (0..90).to_a.exclude? params["age"].to_i
    end

    def user_already_present?
      User.where(email: params["email"]).present?
    end
  end
end
