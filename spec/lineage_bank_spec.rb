# frozen_string_literal: true

require "./spec/spec_helper"

RSpec.describe LineageBlock do
  it "has a version number" do
    expect(LineageBlock::VERSION).not_to be nil
  end
end

RSpec.describe LineageBlock::Bank do
  let(:block) { LineageBlock::Bank.new(name: "BGV") }

  it "has name" do
    expect(block.name).to eq "BGV"
  end

  it "has a identifier" do
    expect(block.identifier).to eq Digest::SHA2.hexdigest("BGV")
  end

  # it "has a previous hash" do
  #   expect(block.prev_hash).to be_nil
  # end

  # it "has a hash" do
  #   expect(block.hash).to be_a String
  # end
end
