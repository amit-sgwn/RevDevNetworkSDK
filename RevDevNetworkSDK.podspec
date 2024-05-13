
Pod::Spec.new do |s|
  s.name             = 'RevDevNetworkSDK'
  s.version          = '1.0.0'  # Set this to your framework's version
  s.summary          = 'A short description of RevDevNetworkSDK.'
  s.description      = <<-DESC
                        An extended description of RevDevNetworkSDK.
                       DESC
  s.homepage         = 'https://homepage-of-RevDevNetworkSDK.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'amitsangwan898@gmail.com' }
  s.source = { :git => 'https://github.com/yourusername/RevDevNetworkSDK.git', :tag => '1.0.0' }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.platform     = :ios
  s.vendored_frameworks = 'RevDevNetworkSDK.xcframework'

  s.requires_arc = true
end
