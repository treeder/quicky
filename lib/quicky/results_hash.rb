module Quicky

  class ResultsHash < Hash

    # returns results in a straight up hash.
    def to_hash
      ret = {}
      self.each_pair do |k,v|
        ret[k] = v.to_hash()
      end
      ret
    end
  end

end