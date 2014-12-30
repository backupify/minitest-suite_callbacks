$LOAD_PATH.push 'lib', __FILE__

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/suite_callbacks'

require 'coveralls'
Coveralls.wear!

Minitest::Spec.extend(Minitest::SuiteCallbacks)
