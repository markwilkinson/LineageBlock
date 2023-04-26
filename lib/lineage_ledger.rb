# frozen_string_literal: true

require "ledger-lite"

module LineageLedger
  class Error < StandardError
  end

  # This class represents a block
  class Ledger < LedgerLite::Ledger
    attr_reader :data, :timestamp, :prev_hash, :hash

    def initialize(data:, prev_hash: nil)
      super.new
    end

    def unpack(tx)
      if tx.is_a?(Hash) # support hashes
        from   = tx[:from]
        to     = tx[:to]
        qty    = tx[:qty]
        species = tx[:species]
      else ## assume it's a transaction (tx) struct/class
        from   = tx.from
        to     = tx.to
        qty    = tx.qty
        species = tx.species
      end
      [from, to, qty, species]
    end

    def send(from, to, qty, species)
      if sufficient?(from, qty, species)
        if self.class.config.coinbase?(from)
          # NOTE: coinbase has unlimited supply!! magic happens here
        else
          @addr[from][species] -= qty
        end
        @addr[to] ||= {}     # make sure addr exists (e.g. init with empty hash {})
        @addr[to][species] ||= 0
        @addr[to][species] += qty
      else
        warn "insufficient resources to do this!"
      end
    end
  end
end
