module Retrier
  class ConditionError < ArgumentError
    def message
      'Condition Object should respond to #to_proc'
    end
  end

  module_function

  def attempt(condition, tries: 5, delay: 5.seconds)
    raise ConditionError unless condition.respond_to? :to_proc

    condition = condition.to_proc
    tries.times do
      result = begin
                 yield
               rescue
                 false
               end
      return result if condition.call(result)
      sleep(delay)
    end
    false
  end

  def attempt!(condition, tries: 100, delay: 5.seconds, error: nil, &block)
    return true if attempt(condition, tries: tries, delay: delay, &block)
    raise error if error
    false
  end
end
