class Series::TeamAssessmentRows::BaseDecorator < ApplicationDecorator
  def to_s
    "#{team.name} #{team_number}"
  end

  def participations_for_cup(cup)
    object.participations_for_cup(cup).map(&:decorate)
  end
end