require 'test_helper'

class CallCountTest < Minitest::Spec
  before_suite_call_count = 0
  after_suite_call_count = 0

  before_suite do
    before_suite_call_count += 1
  end

  after_suite do
    after_suite_call_count += 1
    assert after_suite_call_count == 1
  end

  (1..3).each do |i|
    has_run = false
    it "is called the appropriate number of times#{i}" do
      assert before_suite_call_count == 1
      assert after_suite_call_count == 0
    end
  end
end
