# frozen_string_literal: true

class UsersController < ApplicationController
  CREATE_PERMIT_PARAMS = %i[name patronymic surname email age gender nationality country interests skills]
  def create
    interact = Users::Create.run(permit_params)

    if interact.result
      render json: { user: interact.result.id }, status: :ok
    else
      render status: :unprocessable_content
    end
  end

  private

  def permit_params
    params.permit(
      :name,
      :patronymic,
      :surname,
      :email,
      :age,
      :gender,
      :nationality,
      :country,
      interests: [],
      skills: []
    ).to_hash
  end
end
