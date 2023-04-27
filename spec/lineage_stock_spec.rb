# frozen_string_literal: true

require "./spec/spec_helper"

RSpec.describe LineageBlock do
  it "has a version number" do
    expect(LineageBlock::VERSION).not_to be nil
  end
end

lsid = "urn:lsid:species.org:abd123"

RSpec.describe LineageBlock::Stock do

  let(:block) { LineageBlock::Stock.new(species: lsid) }

  it "has name" do
    expect(block.species).to eq lsid
  end

  it "has a identifier" do
    expect(block.identifier).to eq Digest::SHA2.hexdigest(lsid)
  end

end
