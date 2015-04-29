module Score
  class ListsController < ApplicationController
    implement_crud_actions 
    before_action :assign_resource_for_action, only: [:move, :finished]

    def finished
      @waiting_entries = @score_list.entries.select(&:result_waiting?)
      @unvalid_entries = @score_list.entries.select(&:result_valid?).reject(&:stopwatch_time_valid?)
      @available_time_types = @score_list.available_time_types
      @score_list.result_time_type ||= @available_time_types.first
    end
  
    protected

    def assign_resource_for_action
      assign_existing_resource
    end
    
    def build_resource
      resource_class.new(assessment_id: params[:assessment])
    end

    def score_list_params
      params.require(:score_list).permit(:name, :assessment_id, :generator, :track_count, entries_attributes: [:id, :run, :track])
    end
  end
end