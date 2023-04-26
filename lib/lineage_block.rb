# frozen_string_literal: true
require 'digest/sha2'
module LineageBlock
  class Error < StandardError
  end

  # This class represents a block
  class Block
    attr_reader :data, :timestamp, :prev_hash, :hash
  
    def initialize(data:, prev_hash: nil)
      @data = data
      @timestamp = Time.now
      @prev_hash = prev_hash
      @hash = calculate_hash
    end
  
    def calculate_hash
      Digest::SHA256.hexdigest("#{@prev_hash}#{@timestamp}#{@data}")
    end
  end
  
  # This class represents the blockchain
  class Blockchain
    attr_reader :chain
  
    def initialize
      @chain = [genesis_block]
    end
  
    def genesis_block
      Block.new(data: "This is the first block in the chain.", prev_hash: "0")
    end
  
    def last_block
      @chain[-1]
    end
  
    def add_block(data:)
      new_block = Block.new(data: data, prev_hash: last_block.hash)
      @chain << new_block
    end
  
    def valid?
      (1...@chain.length).all? do |i|
        @chain[i].prev_hash == @chain[i - 1].hash
      end
    end
  end
end
