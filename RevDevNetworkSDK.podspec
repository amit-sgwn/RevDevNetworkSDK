
Pod::Spec.new do |s|
  s.name             = 'RevDevNetworkSDK'
  s.version          = '1.0.1'  # Set this to your framework's version
  s.summary          = 'A short description of RevDevNetworkSDK.'
  s.description      = <<-DESC
                        An extended description of RevDevNetworkSDK.
                       DESC
  s.homepage         = 'https://homepage-of-RevDevNetworkSDK.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'amitsangwan898@gmail.com' }
 s.source = { :http => 'https://github.com/amit-sgwn/RevDevNetworkSDK/releases/download/1.0.1/RevDevNetworkSDK.xcframework.zip' }


  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'
  s.platform     = :ios
  s.vendored_frameworks = 'RevDevNetworkSDK.xcframework'

  s.requires_arc = true
end
