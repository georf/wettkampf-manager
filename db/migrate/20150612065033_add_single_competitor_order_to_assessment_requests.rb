class AddSingleCompetitorOrderToAssessmentRequests < ActiveRecord::Migration
  def change
    add_column :assessment_requests, :single_competitor_order, :integer, default: 0, null: false
  end
end