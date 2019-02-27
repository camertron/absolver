require 'spec_helper'

describe Exception do
  describe '#cause=' do
    let(:exc) { begin; 1 / 0; rescue => e; e; end }
    let(:cause) { RuntimeError.new('foobar') }

    it 'allows the cause to be set' do
      expect { exc.cause = cause }.to(
        change { exc.cause }.from(nil).to(cause)
      )
    end

    it 'allows the cause to be set to nil' do
      exc.cause = cause

      expect { exc.cause = nil }.to(
        change { exc.cause }.from(cause).to(nil)
      )
    end
  end
end
