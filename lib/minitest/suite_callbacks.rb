# TODO: Make it work when we have a base level
# before_suite and a context/describe
#
# It just doesn't work at all with contexts & suite-wide setup
module Minitest::SuiteCallbacks
  def self.extended(base)
    base.class_eval do
      class << self
        attr_reader :sandbox

        # DSL method
        def before_suite(&before_suite_proc)
          @before_suite_proc = before_suite_proc
          # Setup state before suite
          context = self
          original_singleton_run = method(:run)
          define_singleton_method :run do |*args, &block|
            context.setup_before_suite
            original_singleton_run.call(*args, &block)
          end

          # TODO what if we call before_suite multiple times?
          original_instance_run = instance_method(:run)
          define_method :run do |*args, &block|
            context.transfer_sandbox_state_to(self)
            original_instance_run.bind(self).call(*args, &block)
          end
        end

        def after_suite(&after_suite_proc)
          context = self
          original_singleton_run = method(:run)
          define_singleton_method :run do |*args, &block|
            original_singleton_run.call(*args, &block)
            context.sandbox.instance_eval &after_suite_proc
          end
        end

        def setup_before_suite
          @sandbox = new('sandbox')
          @sandbox.instance_eval &@before_suite_proc
        end

        def transfer_sandbox_state_to(dest_context)
          # TODO: generate these
          ivs_to_skip = [:@NAME, :@assertions, :@failures]
          iv_map = {}
          @sandbox.instance_variables.each do |iv|
            next if ivs_to_skip.include?(iv)
            iv_map[iv] = @sandbox.instance_variable_get(iv.to_sym)
          end
          
          dest_context.instance_eval do
            iv_map.each do |k, v|
              instance_variable_set k, v
            end
          end
        end
      end
    end
  end
end

