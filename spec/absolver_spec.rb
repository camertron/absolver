require 'spec_helper'

describe Absolver do
  describe '.set_cause' do
    let(:exc) { begin; 1 / 0; rescue => e; e; end }
    let(:cause) { RuntimeError.new('foobar') }

    it 'sets the cause on an exception' do
      expect { Absolver.set_cause(exc, cause) }.to(
        change { exc.cause }.from(nil).to(cause)
      )
    end

    it 'allows the cause to be set to nil' do
      Absolver.set_cause(exc, cause)

      expect { Absolver.set_cause(exc, nil) }.to(
        change { exc.cause }.from(cause).to(nil)
      )
    end
  end
end
