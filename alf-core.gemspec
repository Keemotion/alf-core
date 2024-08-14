Gem::Specification.new do |s|
  s.name = "alf-core"
  s.version = "0.17.8"
  s.summary = "Relational Algebra at your fingertips"
  s.description = "Alf brings the relational algebra both in Shell and in Ruby. In Shell, because\nmanipulating any relation-like data source should be as straightforward as a\none-liner. In Ruby, because I've never understood why programming languages\nprovide data structures like arrays, hashes, sets, trees and graphs but not\n_relations_... Let's stop the segregation ;-)"
  s.homepage = "http://blambeau.github.com/alf"
  s.authors = ["Bernard Lambeau"]
  s.email  = ["blambeau@gmail.com"]
  s.require_paths = ['lib']
  s.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z 2>/dev/null`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.add_development_dependency("rake", "~> 13.0")
  s.add_development_dependency("rspec", "~> 3.0")
  s.add_development_dependency("highline", "~> 1.6")
  s.add_development_dependency("ruby_cop", "~> 1.0")
  s.add_dependency("myrrha", "~> 3.0")
  s.add_dependency("domain", "~> 1.0")
  s.add_dependency("path", "~> 2.0")
  s.add_dependency("sexpr", "~> 1.0")

end
