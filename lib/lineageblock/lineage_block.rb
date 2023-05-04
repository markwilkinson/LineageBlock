# frozen_string_literal: true

require "digest/sha2"
require "blockchain-lite"
# Block = BlockchainLite::ProofOfWork::Block
module LineageBlock
  class Error < StandardError
  end

  # This class represents a block
  class Block < BlockchainLite::ProofOfWork::Block
    attr_reader :data, :timestamp, :prev_hash, :hash

    def to_h
      { index: @index,
        timestamp: @timestamp,
        nonce: @nonce,
        # transactions: @transactions.map { |tx| tx.to_h },
        transactions: @transactions.map(&:to_h),
        previous_hash: @previous_hash }
    end

    def self.from_h(h)
      transactions = h["transactions"].map { |h_tx| Tx.from_h(h_tx) }

      ## parse iso8601 format e.g 2017-10-05T22:26:12-04:00
      timestamp    = Time.parse(h["timestamp"])

      new(h["index"],
          transactions,
          h["previous_hash"],
          timestamp: timestamp,
          nonce: h["nonce"].to_i)
    end

    def valid?
      true ## for now always valid
    end
  end

  # This class represents the blockchain
  class Blockchain
    extend Forwardable
    def_delegators :@chain, :[], :size, :each, :empty?, :any?, :last

    def initialize(chain = [])
      @chain = chain
    end

    def timestamp1637
      ## change year to 1637 :-)
      ##   note: time (uses signed integer e.g. epoch/unix time starting in 1970 with 0)
      ##  todo: add nano/mili-seconds - why? why not? possible?
      now = Time.now.utc.to_datetime
      DateTime.new(1637, now.month, now.mday, now.hour, now.min, now.sec, now.zone)
    end

    def <<(txs)
      ## todo: check if is block or array
      ##   if array (of transactions) - auto-add (build) block
      ##   allow block - why? why not?
      ##  for now just use transactions (keep it simple :-)

      block = if @chain.size.zero?
                Block.first(txs, timestamp: timestamp1637)
              else
                Block.next(@chain.last, txs, timestamp: timestamp1637)
              end
      @chain << block
    end

    def as_json
      # @chain.map { |block| block.to_h }
      @chain.map(&:to_h)
    end

    def transactions
      ## "accumulate" get all transactions from all blocks "reduced" into a single array
      @chain.reduce([]) { |acc, block| acc + block.transactions }
    end

    def self.from_json(data)
      ## note: assumes data is an array of block records/objects in json
      chain = data.map { |h| Block.from_h(h) }
      new(chain)
    end
  end  # class Blockchain
end
