Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "Framework"
s.summary = "Pod is related to framework (methods for service calls)."
s.requires_arc = true

s.version = "0.1.1"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Pallav Trivedi" => "pallavtrivedi03@gmail.com" }

s.homepage = "https://github.com/pallavtrivedi03/Framework"

s.source = { :git => "https://github.com/pallavtrivedi03/Framewok.git", :tag => "#{s.version}"}

s.source_files = "Framework/*.{swift}"

end
