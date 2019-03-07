Pod::Spec.new do |s|
  s.name             = 'EFCountingLabel'
  s.version          = '4.2.1'
  s.summary          = 'A label which can show number change animated.'

  s.description      = <<-DESC
A label which can show number change animated, in Swift.
                       DESC

  s.homepage         = 'https://github.com/EFPrefix/EFCountingLabel'
  s.screenshot       = 'https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/example.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EyreFree' => 'eyrefree@eyrefree.org' }
  s.source           = { :git => 'https://github.com/EFPrefix/EFCountingLabel.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EyreFree777'

  s.ios.deployment_target = '8.0'
  s.source_files = 'EFCountingLabel/Classes/*.swift'
end
