Pod::Spec.new do |s|
  s.name             = 'EFCountingLabel'
  s.version          = '4.1.0'
  s.summary          = 'A label which can show number change animated.'

  s.description      = <<-DESC
A label which can show number change animated, in Swift.
                       DESC

  s.homepage         = 'https://github.com/EyreFree/EFCountingLabel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EyreFree' => 'eyrefree@eyrefree.org' }
  s.source           = { :git => 'https://github.com/EyreFree/EFCountingLabel.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EyreFree777'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'EFCountingLabel/Classes/*.swift'
end
