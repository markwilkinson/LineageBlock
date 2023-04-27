# stdlibs
require "json"
require "digest"
require "net/http"
require "set"
require "optparse"
require "pp"

### 3rd party gems
require "sinatra/base"                         # NOTE: use "modular" sinatra app / service

require "merkletree"
require "blockchain-lite/proof_of_work/block"  # NOTE: use proof-of-work block only (for now)

### our own code
# require 'tulipmania/version'    ## let version always go first
# require 'tulipmania/block'
# require 'tulipmania/cache'
# require 'tulipmania/transaction'
# require 'tulipmania/blockchain'
# require 'tulipmania/pool'
# require 'tulipmania/exchange'
# require 'tulipmania/ledger'
# require 'tulipmania/wallet'

# require 'tulipmania/node'
# require 'tulipmania/service'

# require 'tulipmania/tool'

require_relative "./lineageblock/version"
require_relative "./lineageblock/service"
require_relative "./lineageblock/lineage_block"
require_relative "./lineageblock/lineage_bank"
require_relative "./lineageblock/lineage_ledger"
require_relative "./lineageblock/lineage_stock"

# This is the main thingy

module LineageBlock

  # This is the main Configuration

  class Configuration
    ## user/node settings
    attr_accessor :address ## Addreswsw of this wallet
    BANKS = load_banks
    # ['BGV', 'Gatersleben]

    ## system/blockchain settings
    attr_accessor :coinbase
    attr_accessor :mining_reward, :species ## rename to assets/commodities/etc. - why? why not?

    ## note: add a (†) coinbase / grower marker
    #TULIP_GROWERS = ["Dutchgrown†", "Keukenhof†", "Flowers†",
    #                 "Bloom & Blossom†", "Teleflora†"]

    SPECIES = load_species

    def initialize
      ## try default setup via ENV variables
      ## pick "random" address if nil (none passed in)
      @address = ENV["GERMPLASM_BANK_NAME"] || "BGV"

      #@coinbase      = TULIP_GROWERS ## use a different name for coinbase - why? why not?
      ##  note: for now is an array (multiple growsers)

      @tulips        = TULIPS ## change name to commodities or assets - why? why not?
      @mining_reward = 5
    end

    #def rand_address = WALLET_ADDRESSES.[](rand(WALLET_ADDRESSES.size))
    #def rand_tulip = @tulips.[](rand(@tulips.size))
    #def rand_coinbase = @coinbase.[](rand(@coinbase.size))

    def coinbase?(address) ## check/todo: use wallet - why? why not? (for now wallet==address)
      @coinbase.include?(address)
    end

    def load_banks # "wallets"
      { "BGV" => Digest::SHA2.hexdigest("BGV"), "Gatersleben" => Digest::SHA2.hexdigest("Gatersleben") }
    end

    def load_stocks # "currencies"
      { "https://www.gbif.org/species/2764178" => { name: "Commelina cyanea" }, "https://www.gbif.org/species/3118274" => { name: "Tanacetum vulgare L." } }
    end
  end # class Configuration

  ## lets you use
  ##   Tulipmania.configure do |config|
  ##      config.address = 'Anne'
  ##   end

  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Configuration.new
  end

  ## add command line binary (Application) e.g. $ try centralbank -h
  def self.main
    Application.new.run(ARGV)
  end
end # module LinageBlock

# say hello
puts Tulipmania::Service.banner
