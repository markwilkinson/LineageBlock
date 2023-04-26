# frozen_string_literal: true

warn `pwd`; abort

require "./spec/spec_helper"

RSpec.describe LineageBlock do
  it "has a version number" do
    expect(LineageBlock::VERSION).not_to be nil
  end
end

RSpec.describe LineageBlock::Block do
  let(:block) { LineageBlock::Block.new(data: "test data") }

  it "has data" do
    expect(block.data).to eq "test data"
  end

  it "has a timestamp" do
    expect(block.timestamp).to be_a Time
  end

  it "has a previous hash" do
    expect(block.prev_hash).to be_nil
  end

  it "has a hash" do
    expect(block.hash).to be_a String
  end
end

# Test the Blockchain class
RSpec.describe LineageBlock::Blockchain do
  let(:blockchain) { LineageBlock::Blockchain.new }

  it "has a chain" do
    expect(blockchain.chain).to be_an Array
  end

  it "has a genesis block" do
    expect(blockchain.chain[0].data).to eq "This is the first block in the chain."
    expect(blockchain.chain[0].prev_hash).to eq "0"
  end

  it "can add blocks" do
    blockchain.add_block(data: "test data")
    expect(blockchain.chain.length).to eq 2
  end

  it "can check the validity of the chain" do
    blockchain.add_block(data: "test data")
    expect(blockchain.valid?).to be true
  end
end
