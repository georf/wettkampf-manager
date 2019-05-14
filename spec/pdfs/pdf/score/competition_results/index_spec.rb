require 'rails_helper'

RSpec.describe PDF::Score::CompetitionResults::Index, type: :model do
  let(:index_pdf) { described_class.perform([score_competition_result]) }
  let(:score_competition_result) { create(:score_competition_result).decorate }

  describe 'perform' do
    it 'creates pdf' do
      expect(index_pdf.bytestream).to start_with '%PDF-1.3'
      expect(index_pdf.bytestream).to end_with "%%EOF\n"
      expect(index_pdf.bytestream.size).to be_within(40_308).of(2000)
    end
  end
end
