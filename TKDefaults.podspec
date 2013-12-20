Pod::Spec.new do |s|
  s.name         = "TKDefaults"
  s.version      = "0.1.0"
  s.summary      = "A short description of TKDefaults."
  s.description  = <<-DESC
                    An optional longer description of TKDefaults

                    * Markdown format.
                    * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "http://EXAMPLE/NAME"
  s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "Taras Kalapun" => "t.kalapun@gmail.com" }
  s.source       = { :git => "https://github.com/xslim/TKDefaults.git", :head } #:tag => s.version.to_s

  s.platform     = :ios, '6.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  s.preserve_paths = "Scripts/*.sh"
  #s.resources = 'Assets'

  #s.ios.exclude_files = 'Classes/osx'
  #s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
  

  
end
