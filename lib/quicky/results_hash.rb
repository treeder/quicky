module Quicky

  class ResultsHash < Hash

    # returns results in a straight up hash.
    def to_hash
      ret = {}
      self.each_pair do |k, v|
        ret[k] = v.to_hash()
      end
      ret
    end

    # if given the same results from to_hash, this will recreate the ResultsHash
    def self.from_hash(h)
      rh = ResultsHash.new
      h.each_pair do |k, v|
        rh[k] = TimeCollector.from_hash(v)
      end
      rh
    end

    # merges multiple ResultsHash's
    def merge!(rh)
      rh.each_pair do |k, v|
        # v is a TimeCollector
        if self.has_key?(k)
          self[k].merge!(v)
        else
          self[k] = v
        end
      end
    end
  end
end

