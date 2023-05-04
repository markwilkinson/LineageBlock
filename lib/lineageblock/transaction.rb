

class Transaction

  attr_reader :from, :to, :qty, :what, :id

  def initialize( from, to, qty, species, id=SecureRandom.uuid )
    @from   = from
    @to     = to
    @qty    = qty
    @species= species     
    @id     = id
  end

  def self.from_h( hash )
    self.new *hash.values_at( 'from', 'to', 'qty', 'species', 'id' )
  end

  def to_h
    { from: @from, to: @to, qty: @qty, what: @what, id: @id }
  end


  def valid?
    ## check signature in the future; for now always true
    true
  end

end # class Transaction

Tx = Transaction     ## add Tx shortcut / alias
