# frozen_string_literal: true

require "digest"
module LineageBlock
  class Error < StandardError
  end

  # This class represents a "Bank" (equivalent to a crypto wallet)
  class Bank
    @@banks = []

    attr_accessor :name, :identifier, :assets

    def initialize(name:, identifier: nil, assets: {})
      @name = name
      @identifier = Digest::SHA2.hexdigest(name) unless identifier
      @@banks |= [self]
      @assets = assets
    end

    def self.banks
      @@banks
    end

    def banks
      banks
    end

    def self.load(repo: "/tmp/leger_frozen.json")
      if File.exist?("/tmp/leger_frozen.json")
        # File.open("/tmp/leger_frozen.json") do |f|
        #   leger =
      end
    end
  end
end
