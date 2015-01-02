require 'test_helper'

class InstanceMethodAccessTest < Minitest::Spec
  before_suite do
    @instance_method_return_value = instance_method
  end

  after_suite do
    assert instance_method == 'hi'
  end

  it 'has access to instance methods' do
    assert true # test handled by callbacks
  end

  def instance_method
    'hi'
  end
end
