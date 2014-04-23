class Decorator
  def self.decorate(subject)
    subject.instance_eval do
      return if @delegate_list

      @delegate_list = []
      define_singleton_method(:with) do |delegate|
        @delegate_list ||= []
        @delegate_list << delegate
        self
      end

      define_singleton_method(:delegate_list) { @delegate_list }

      define_singleton_method(:method_missing) do |meth, *args, &block|
        begin
          @delegate_list.find do |delegate|
            delegate.respond_to?(meth)
          end.send(meth)
        rescue
          super(meth, *args, &block)
        end
      end
    end
    subject
  end
end
