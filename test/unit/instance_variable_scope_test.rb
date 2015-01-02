require 'test_helper'

class InstanceVariableScopeTest < Minitest::Spec
  before_suite do
    @yo = 'yo'
  end

  after_suite do
    assert @yo == 'yo'
  end

  it 'shares instances variables with the tests' do
    assert @yo == 'yo'
  end
end
