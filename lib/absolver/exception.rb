require 'absolver'

class Exception
  def cause=(new_cause)
    Absolver.set_cause(self, new_cause)
  end
end
