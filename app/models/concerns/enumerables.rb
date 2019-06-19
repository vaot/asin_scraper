concern :Enumerables do
  class_methods do
    def setup_enumerable(array, name)
      setup_queries(array, name)
      setup_setters(array, name)
      setup_scopes(array, name)
    end

    def setup_queries(array, name)
      array.each do |item|
        define_method "#{item}?" do
          self.send(name) == item
        end
      end
    end

    def setup_setters(array, name)
      array.each do |item|
        define_method "#{item}!" do
          self.update!(name => item)
        end
      end
    end

    def setup_scopes(array, name)
      array.each do |item|
        class_eval do
          scope item, -> { where(name => item) }
        end
      end
    end
  end
end
