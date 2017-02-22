Pod::Spec.new do |s|
s.name             = 'Framework'
s.version          = '0.1.1'
s.summary          = 'Provides you the methods to call webservices, manage users, storage and other basic stuffs.'

s.description      = <<-DESC
Provides you the methods to manage webservices calls, users, storage and other basic stuffs.
DESC

s.homepage         = 'https://github.com/pallavtrivedi03/Framework'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Pallav Trivedi' => 'pallavtrivedi03@gmail.com' }
s.source           = { :git => 'https://github.com/pallavtrivedi03/Framework.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.source_files = 'Framework/**/*.swift'

end

