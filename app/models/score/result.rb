require 'score'

module Score
  class Result < ActiveRecord::Base
    belongs_to :assessment
    belongs_to :double_event_result
    has_many :lists

    validates :assessment, presence: true

    scope :gender, -> (gender) { joins(:assessment).merge(Assessment.gender(gender)) }
    scope :group_assessment_for, -> (gender) { gender(gender).where(group_assessment: true) }

    after_destroy :remove_result_from_list

    def to_label
      decorate.to_s
    end

    def rows
      @rows ||= generate_rows.sort
    end

    def generate_rows
      rows = {}
      lists.each do |list|
        list.entries.not_waiting.each do |list_entry|
          if rows[list_entry.entity.id].nil?
            rows[list_entry.entity.id] = ResultRow.new(list_entry.entity, self)
          end
          rows[list_entry.entity.id].add_list(list_entry)
        end
      end
      rows.values
    end
    
    private

    def remove_result_from_list
      lists.update_all(result_id: nil)
    end
  end
end
