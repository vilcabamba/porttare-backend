module IntegerEnumerable
  ##
  # @note freezes array
  def make_enumerable(array)
    array.inject({}) do |memo, name|
      memo[name] = memo.keys.count
      memo
    end.freeze
  end
end
