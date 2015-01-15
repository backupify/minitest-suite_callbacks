require 'test_helper'

class InsideDescribeBlocksTest < Minitest::Spec
  describe 'a one-level block' do
    before_suite do
      @var = 'var'
    end
    
    after_suite do
      assert @var == 'var'
    end

    it 'should share instance variables' do
      assert @var == 'var'
    end
  end

  describe 'a' do
    describe 'nested block' do
      before_suite do
        assert @var2 = 'var2'
      end

      after_suite do
        assert @var2 == 'var2'
      end

      it 'should share instance variables' do
        assert @var2 == 'var2'
      end
    end
  end
end
