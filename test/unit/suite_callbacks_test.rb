require 'test_helper'

# TODO: Move to some place else
class SuiteCallbacksTest < Minitest::Spec
  before_suite do
    @yo_dawg = 'yo'
    @hi = return_hi
  end

  after_suite do
    assert return_hi == 'hi'
  end

  it 'be true' do
    assert true
  end
  
  it 'be false' do
    refute false
  end

  describe 'describe 1' do
    it 'have a yo dawg' do
      assert @yo_dawg == 'yo'
    end

    it 'call an instance method' do
      assert @hi == 'hi'
    end
  end

  describe 'describe 2' do
    #it 'say no' do
      #assert @no == 'no'
    #end

    it 'have @yo_dawg' do
      assert @yo_dawg == 'yo'
    end
  end

  def return_hi
    'hi'
  end

  def say_no
    'no'
  end
end
