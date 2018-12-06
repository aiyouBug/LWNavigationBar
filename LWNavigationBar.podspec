
Pod::Spec.new do |s|


  s.name         = "LWNavigationBar"
  s.version      = "0.0.7"
  s.summary      = "自定义导航栏"

  s.description  = "自定义导航栏，左右和标题item可以为文字，可以为图片，也可以为图文混合，支持回调事件，背景透明度渐变和标题文字透明度渐变"

  s.homepage     = "https://github.com/weilLove/LWNavigationBar"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "weilLove" => "weil218@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/weilLove/LWNavigationBar.git", :tag => "#{s.version}" }

  s.source_files  = "LWNavigationBar/Classess", "LWNavigationBar/Classess/*.{h,m}"

  s.frameworks = "UIKit", "Foundation"

  s.dependency "YYKit"

end
