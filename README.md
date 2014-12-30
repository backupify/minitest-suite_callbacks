minitest-suite_callbacks
========================

`before_suite` and `after_suite` callbacks for Minitest

## Usage
```rb
gem install 'minitest-suite_callbacks'

# in test_helper.rb
Minitest::Spec.extend(Minitest::SuiteCallbacks)

# in test
class MyTest < Minitest::Spec
  before_suite do
    # do something before any tests in this class run
  end

  after_suite do
    # clean up after all tests in this class run
  end
end
```
