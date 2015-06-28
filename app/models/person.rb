class Person < ActiveRecord::Base
  belongs_to :team
  belongs_to :fire_sport_statistics_person, class_name: "FireSportStatistics::Person"
  has_many :requests, class_name: "AssessmentRequest", as: :entity, dependent: :destroy
  has_many :list_entries, class_name: "Score::ListEntry", as: :entity, dependent: :destroy
  has_many :requested_assessments, through: :requests, source: :assessment
  enum gender: { female: 0, male: 1 }
  before_save :assign_registration_order

  validates :last_name, :first_name, :gender, presence: true
  validate :validate_team_gender

  accepts_nested_attributes_for :requests, allow_destroy: true

  default_scope { order(:gender, :last_name, :first_name) }
  scope :registration_order, -> () { reorder(:registration_order) }


  def request_for assessment
    requests.where(assessment: assessment).first
  end
 
  private

  def validate_team_gender
    errors.add(:team, :has_other_gender) if team.present? && team.gender != gender
  end

  def assign_registration_order
    if registration_order == 0 && team.present?
      self.registration_order = (team.people.maximum(:registration_order) || 0) + 1
    end
  end
end
