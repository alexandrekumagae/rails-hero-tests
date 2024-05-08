require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "should get the correct current power" do
    power_base = FFaker::Random.rand(1..3000)
    power_step = FFaker::Random.rand(1..100)
    level = 1

    weapon = create(:weapon, power_base: power_base, power_step: power_step, level: level)
    expect(weapon.current_power).to equal(power_base + ((level - 1) * power_step))
  end

  it "should return the correct weapon name" do
    name = FFaker::Name.first_name
    level = 2

    weapon = create(:weapon, name: name, level: level)
    expect(weapon.title).to eq("#{name}##{level}")
  end
end
