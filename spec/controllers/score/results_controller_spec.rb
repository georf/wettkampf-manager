require 'rails_helper'

RSpec.describe Score::ResultsController, type: :controller, seed: :configured, user: :logged_in do
  let(:result) { create(:score_result) }
  let(:assessment) { create(:assessment) }

  describe 'GET new' do
    it 'renders form' do
      get :new
      expect(response).to be_success
      expect(assigns(:tags)).to eq []
    end
  end

  describe 'POST create' do
    it 'creates result' do
      expect do
        post :create, score_result: { assessment_id: assessment.id }
        expect(response).to redirect_to action: :show, id: Score::Result.last.id
      end.to change(Score::Result, :count).by(1)
      expect(assigns(:tags)).to eq []
    end
  end

  describe 'GET index' do
    it 'renders' do
      get :index
      expect(response).to be_success
      expect(assigns(:tags)).to eq []
    end
  end

  describe 'GET edit' do
    it 'renders form' do
      get :edit, id: result.id
      expect(response).to be_success
      expect(assigns(:tags)).to eq []
    end
  end

  describe 'PATCH update' do
    it 'updates result' do
      patch :update, id: result.id, score_result: { name: 'foo' }
      expect(response).to redirect_to action: :show, id: result.id
      expect(assigns(:tags)).to eq []
    end
  end

  describe 'DELETE destroy' do
    before { result }
    it 'destroys result' do
      expect do
        delete :destroy, id: result.id
        expect(response).to redirect_to action: :index
      end.to change(Score::Result, :count).by(-1)
      expect(assigns(:tags)).to eq []
    end
  end
end