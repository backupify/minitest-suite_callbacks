minitest-suite_callbacks
========================
[![Build Status](https://travis-ci.org/backupify/minitest-suite_callbacks.svg)](https://travis-ci.org/backupify/minitest-suite_callbacks)
[![Coverage Status](https://coveralls.io/repos/backupify/minitest-suite_callbacks/badge.png)](https://coveralls.io/r/backupify/minitest-suite_callbacks)

`before_suite` and `after_suite` callbacks for Minitest

## Installation
```sh
gem install 'minitest-suite_callbacks'
```

## Usage
```rb
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

## TODO
* generate fields filtered out of sandbox
* how does it interact with factory girl?
* best practices docs (db cleaner etc)
* general refactoring
* does it work with multiple before_suites?
* allow for multiple callbacks; separate code into classes; only one sandbox
