# frozen_string_literal: true

module LineageBank
  class Error < StandardError
  end

  # This class represents a block
  class Bank
    @@banks = []

    attr_reader :name, :identifier

    def initialize(name:, identifier:)
      @name = name
      @identifier = identifier
      @@banks |= self
    end

    def self.banks
      @@banks
    end
    def banks
      self.banks
    end

    def self.load(repo:)
    
    end

  end
end
