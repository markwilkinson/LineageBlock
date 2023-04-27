# frozen_string_literal: true

require "digest"

module LineageBlock
  class Error < StandardError
  end

  # This class represents a Stock
  class Stock
    @@stocks = []

    attr_accessor :species, :identifier

    def initialize(species:, identifier: nil)
      @species = species
      @identifier = Digest::SHA2.hexdigest(species) unless identifier
      @@stocks |= [self]
    end

    def self.stocks
      @@banks
    end

    def self.load(ledger: "/tmp/ledger_frozen.json")
      if File.exist?("/tmp/ledger_frozen.json")
        # File.open("/tmp/ledger_frozen.json") do |f|
        #   leger =
      end
      ledger
    end
  end
end
