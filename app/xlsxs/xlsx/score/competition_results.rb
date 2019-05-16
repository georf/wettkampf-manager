XLSX::Score::CompetitionResults = Struct.new(:results) do
  include XLSX::Base
  include Exports::CompetitionResults

  def perform
    results.each do |result|
      workbook.add_worksheet(name: result.short_name) do |sheet|
        table_data(result).each { |row| sheet.add_row(row) }
      end
    end
  end
end