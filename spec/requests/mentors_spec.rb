require 'rails_helper'

RSpec.describe 'Mentors', type: :request do
  describe 'GET /mentors' do
    context 'when mentors exist' do
      before do
        Mentor.create!(
          first_name: 'Ada',
          last_name: 'Lovelace',
          email: 'ada@example.com',
          max_concurrent_students: 3
        )
        Mentor.create!(
          first_name: 'Grace',
          last_name: 'Hopper',
          email: 'grace@example.com',
          max_concurrent_students: 2
        )
      end

      it 'returns a page containing mentors data' do
        get '/mentors'

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Mentors')

        expect(response.body).to include('Ada')
        expect(response.body).to include('Lovelace')
        expect(response.body).to include('ada@example.com')

        expect(response.body).to include('Grace')
        expect(response.body).to include('Hopper')
        expect(response.body).to include('grace@example.com')
      end
    end

    context 'when no mentors exist' do
      it 'still renders the mentors index page' do
        Mentor.delete_all

        get '/mentors'

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Mentors')
      end
    end
  end

  describe 'GET /mentors/:id' do
    it 'returns a page containing the mentor data' do
      mentor = Mentor.create!(
        first_name: 'Katherine',
        last_name: 'Johnson',
        email: 'katherine@example.com',
        max_concurrent_students: 4
      )

      get "/mentors/#{mentor.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('katherine@example.com')
      expect(response.body).to include('Katherine')
      expect(response.body).to include('Johnson')
    end

    it 'returns 404 when the mentor does not exist' do
      get '/mentors/999999999'
      expect(response).to have_http_status(:not_found)
    end
  end
end
