# TODO: Make it work when we have a base level
# before_suite and a context/describe
#
# It just doesn't work at all with contexts & suite-wide setup
module Minitest::SuiteCallbacks
  def self.extended(base)
    class << base
      attr_reader :sandbox
      attr_accessor :counter

      # Define before_suite on the test class context
      def before_suite(&before_suite_proc)
        # Setup state before suite
        context = self
        singleton_class.class_eval do
          original_singleton_run = instance_method(:run)
          # Wrap the run method on the singleton class of the test class
          define_method :run do |*args, &block|
            # TODO this is kind of hacky; it only runs before_suite once
            # I don't think this will support other use cases (e.g. multiple before_suites/nested before_suites)
            context.instance_eval do
              if @sandbox.nil?
                @sandbox = new('sandbox')
                @sandbox.instance_eval &before_suite_proc
              end
            end
            original_singleton_run.bind(self).call(*args, &block)
          end
        end

        # TODO what if we call before_suite multiple times?
        original_instance_run = instance_method(:run)
        define_method :run do |*args, &block|
          context.transfer_sandbox_state_to(self)
          original_instance_run.bind(self).call(*args, &block)
        end
      end

      # TODO: because of how Minitest separates its suites, this method gets called after EACH suite, 
      # not after all related suites are finished
      def after_suite(&after_suite_proc)
        @counter = 0
        context = self
        singleton_class.class_eval do
          original_singleton_run = instance_method(:run)
          define_method :run do |*args, &block|
            original_singleton_run.bind(self).call(*args, &block)
            context.instance_eval do
              @counter += 1
              if has_run_all_related_suites?
                @sandbox.instance_eval &after_suite_proc
              end
            end
          end
        end
      end

      def has_run_all_related_suites?
        # Get the number of subclasses + the class itself
        @counter == descendant_count + 1
      end

      def descendant_count
        ObjectSpace.each_object(::Class).select{|k| k < self}.size
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

