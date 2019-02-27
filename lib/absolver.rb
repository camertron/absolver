require 'fiddle'

module Absolver
  class << self
    def set_cause(exc, new_cause)
      rb_ivar_set(exc, 'cause', new_cause)
    end

    private

    def rb_ivar_set(mod, str, new_val)
      id = rb_intern_str(str)
      m = Fiddle.dlwrap(mod)
      nv = Fiddle.dlwrap(new_val)
      Fiddle.dlunwrap(rb_ivar_set_func.call(m, id, nv))
    end

    def rb_ivar_set_func
      @rb_ivar_set_func ||= Fiddle::Function.new(
        Fiddle::Handle::DEFAULT['rb_ivar_set'],
        [Fiddle::TYPE_VOIDP] * 3,  # arguments
        Fiddle::TYPE_VOIDP         # return type
      )
    end

    def rb_intern_str(str)
      rb_intern_str_func.call(Fiddle.dlwrap(str))
    end

    def rb_intern_str_func
      @rb_intern_str_func ||= Fiddle::Function.new(
        Fiddle::Handle::DEFAULT['rb_intern_str'],
        [Fiddle::TYPE_VOIDP],  # arguments
        Fiddle::TYPE_VOIDP     # return type
      )
    end
  end
end
