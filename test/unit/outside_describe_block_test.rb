require 'test_helper'

class OutsideDescribeBlockTest < Minitest::Spec
  @before_suite_call_count = 0
  @after_suite_call_count = 0

  class << self
    attr_accessor :before_suite_call_count, :after_suite_call_count
  end

  before_suite do
    OutsideDescribeBlockTest.before_suite_call_count += 1
  end

  after_suite do
    OutsideDescribeBlockTest.after_suite_call_count += 1
  end

  describe 'a describe block' do
    it 'should call top-level callbacks the right number of times' do
      assert_equal 1, OutsideDescribeBlockTest.before_suite_call_count, 'expected before_suite to be correct'
      assert_equal 0, OutsideDescribeBlockTest.after_suite_call_count, 'expected after_suite to be correct'
    end
  end
end
