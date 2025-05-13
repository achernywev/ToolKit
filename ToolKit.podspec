Pod::Spec.new do |s|
  s.name                  = "ToolKit"
  s.version               = "1.0.0"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.summary               = "Set of tools and presets to simplify the development process"
  s.description           = <<-DESC
    "Set of tools and presets to simplify the development process"
    DESC
  s.homepage              = "https://github.com/achernywev/ToolKit"
#  s.source                = { :git => "https://https://github.com/achernywev/ToolKit", :tag => s.version.to_s }
  s.source                = { :git => "https://github.com/achernywev/ToolKit" }
  s.author                = { "Aleksandr Chernyshev" => "achernywev@gmail.com" }
  s.social_media_url      = "https://www.linkedin.com/in/achernywev"
  s.platform              = :ios
  s.ios.deployment_target = "13.0"
  s.requires_arc          = true
  s.swift_version         = "5.0"
  
  s.source_files          = "Sources/**/*.{h,m,swift}"
  s.dependency 'SnapKit'
  s.dependency 'Swinject'
  s.dependency 'SkeletonView'
  s.dependency 'KeychainAccess'
  s.dependency 'Mixpanel-swift'
  
  s.frameworks            = "UIKit", "Foundation"
  s.pod_target_xcconfig   = { 'APPLICATION_EXTENSION_API_ONLY' => 'NO' }
end
