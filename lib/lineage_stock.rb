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

    def self.load(leger: "/tmp/leger_frozen.json")
      if File.exist?("/tmp/leger_frozen.json")
        # File.open("/tmp/leger_frozen.json") do |f|
        #   leger =
      end
    end
  end
end
