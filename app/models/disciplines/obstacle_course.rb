# frozen_string_literal: true

class Disciplines::ObstacleCourse < Discipline
  def single_discipline?
    true
  end

  def key
    :hb
  end
end
