require 'spec_helper'
describe :clojures_and_scoping do

  class Foo

    def a_method
      :inside
    end

    def evaluate(lamb)
      if RUBY_VERSION <= "1.9"
        self.instance_eval(&lamb)
      else
        self.instance_exec(&lamb)
      end
    end

  end

  specify "when no name clash" do
    expect(Foo.new.evaluate(lambda{ a_method })).to eq(:inside)
  end

  specify "with name clash" do
    a_method = :outside
    expect(Foo.new.evaluate(Proc.new{ a_method })).to eq(:outside)
  end

end
