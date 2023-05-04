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
require_relative "./lineageblock/node"
require_relative "./lineageblock/pool"
require_relative "./lineageblock/exchange"
require_relative "./lineageblock/wallet"
require_relative "./lineageblock/cache"
require_relative "./lineageblock/transaction"
require_relative "./lineageblock/main_application"
require_relative "./lineageblock/web_service"

# This is the main thingy

module LineageBlock

  # This is the main Configuration

  class Configuration
    ## user/node settings
    attr_accessor :wallet ## Addreswsw of this wallet

    BANKS = load_banks
    SPECIES = load_species

    # attr_accessor :coinbase
    attr_accessor :mining_reward, :species ## rename to assets/commodities/etc. - why? why not?

    ## note: add a (†) coinbase / grower marker
    # TULIP_GROWERS = ["Dutchgrown†", "Keukenhof†", "Flowers†",
    #                 "Bloom & Blossom†", "Teleflora†"]


    def initialize
      ## try default setup via ENV variables
      ## pick "random" address if nil (none passed in)
      @wallet = ENV["GERMPLASM_BANK_NAME"] || "BGV"

      #@coinbase      = CORE

      @species        = SPECIES
      @mining_reward = 0
    end

    # def coinbase?(wallet) 
    #  @coinbase.include?(wallet)
    # end

    def load_banks # "wallets"
      return { Digest::SHA2.hexdigest("BGV") => "BGV", Digest::SHA2.hexdigest("Gatersleben") => "Gatersleben" }
    end

    def load_species # "currencies"
      return { "https://www.gbif.org/species/2764178" => { name: "Commelina cyanea" }, "https://www.gbif.org/species/3118274" => { name: "Tanacetum vulgare L." } }
    end
  end # class Configuration

  ## lets you use
  ##   LineageBlock.configure do |config|
  ##      config.wallet = Digest::SHA2.hexdigest("BGV")
  ##   end

  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Configuration.new
  end

  ## add command line binary (Application)
  def self.main
    Application.new.run(ARGV)
  end
end # module LinageBlock

# say hello
puts LineageBlock::Service.banner
