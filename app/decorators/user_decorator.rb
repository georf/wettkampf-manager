# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  decorates_association :assessments

  def to_s
    name
  end
end
