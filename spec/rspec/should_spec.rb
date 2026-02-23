# frozen_string_literal: true

RSpec.describe RSpec::Should do
  it "enables the <object>.should syntax" do
    object = Object.new
    object.should eq object
  end

  it "enables should_not" do
    object = Object.new
    object.should_not eq 2
  end

  it "enables the one line syntax" do
    should eq(self)
    should_not eq(2)
  end

  it "enables operators"
end
