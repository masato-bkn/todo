require 'rails_helper'

RSpec.describe TaskController, type: :request do
  describe 'GET /' do
    subject do
      get root_path
      response
    end

    it 'returns success' do
      expect(subject).to have_http_status(:success)
    end

  end
end