require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /enemies" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) {
        put "/enemies/#{enemy.id}", params: enemy_attributes
      }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "updates the record" do
        expect(enemy.reload).to have_attributes(enemy_attributes)
      end
      
      it "returns the enemy updated" do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end

    context "when the enemy does not exist" do
      before(:each) {
        put "/enemies/0", params: attributes_for(:enemy)
      }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "DELETE /enemies" do
    context "when the enemy exists" do
      let(:enemy) { 
        create(:enemy)
      }

      before(:each) {
        delete "/enemies/#{enemy.id}"
      }
      
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "destroy the record" do
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when the enemy does not exist" do
      before(:each) {
        delete "/enemies/0"
      }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  # describe "GET /enemies" do
  #   context "when the enemy exists" do
  #     let(:enemy) { create(:enemy) }
  #     let(:enemy_attributes) { attributes_for(:enemy) }

  #     it "return the enemies list" do
  #       get "/enemies"

  #       enemies_response = JSON.parse(response.body)

  #       expect(enemies_response).not_to be_empty
  #     end

  #     it "returns the enemy based on ID" do
  #       get "/enemies/#{enemy.id}"

  #       expect(response).to have_http_status(200)
  #     end
  #   end
  # end

  # describe "POST /enemies" do
  #   context "when it has valid parameters" do
  #     it "creates the enemy with correct attributes" do 
  #     end
  #   end

  #   context "when it has no valid parameters" do 
  #     it "does not create enemy" do
  #     end
  #   end
  # end
end
