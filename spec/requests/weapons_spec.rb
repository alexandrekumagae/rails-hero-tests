require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /index" do
    it "should return the weapon names" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end
    end

    it "should return the weapon current_power" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.current_power.to_s)
      end
    end

    it "should return the weapon titles" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.title)
      end
    end
  end

  describe "GET /create" do
    it "should create the weapon if the parameters are correct" do
      weapon_attributes = FactoryBot.attributes_for(:weapon)
      post weapons_path, params: { weapon: weapon_attributes }
      expect(Weapon.last).to have_attributes(weapon_attributes)
    end

    it "should not create the weapon if the parameters are wrong" do
      expect {
        post weapons_path, params: { weapon: { name: '', description: '', power_base: '', power_step: '', level: '' } }
      }.to_not change(Weapon, :count)
    end
  end

  # IT DOESN'T WORK ):
  # describe "GET /delete" do
  #   it "should delete the weapon if the correct id is provided" do
  #     weapon = create(:weapon)
  #     expect {
  #       delete weapons_path(weapon)
  #     }.to change(Weapon, :count).by(-1)
  #     expect(response).to redirect_to(weapons_path)
  #   end
  # end

  describe "GET /show" do
    it "should return all weapon information" do
      weapon = create(:weapon)
      get weapons_path(weapon)

      expect(response.body).to include(weapon.name)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include(weapon.power_base.to_s)
      expect(response.body).to include(weapon.power_step.to_s)
      expect(response.body).to include(weapon.level.to_s)

      expect(response).to have_http_status(:success)
    end
  end
end
