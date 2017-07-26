Pod::Spec.new do |s|
s.name         = "LQGPhotoKit"
s.version      = "1.0.0"
s.ios.deployment_target = '8.0'
s.summary      = "相册开源库"
s.description  = <<-DESC
                        LQGPhotoKit 相册开源库
                    DESC
s.homepage     = "https://github.com/liquangang/LQGPhotoKit"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "liquangang" => "1347336730@qq.com" }
s.source       = { :git => "https://github.com/liquangang/LQGPhotoKit.git", :tag => "#{s.version}" }
s.source_files  = "LQGPhotoKit/**/*"
end
