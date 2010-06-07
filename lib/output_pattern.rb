class OutputPattern
  attr_reader :description, :command_pattern

  def initialize description, command_pattern, & block
    @description = description
    @command_pattern = command_pattern
    @block = block
  end

  def match tokens
    match = @command_pattern.match(tokens)
    if match
      args = match.to_a
      args.shift
      run *args
      #puts "matched #{@description}: #{match.inspect}"
      #puts match.post_match.inspect
      return match.post_match
      else
      return nil
    end
  end

  def run *args
    @block.call *args
  end
end