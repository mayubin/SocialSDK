Pod::Spec.new do |s|
    s.name              = 'SocialSDK'
    s.version           = '0.0.3'
    s.summary           = 'SocialSDK SDK for iOS'
    s.homepage          = 'https://github.com/GagSquad/SocialSDK'
    s.author            = { 'itlijunjie@gmail.com' => 'https://github.com/itlijunjie', 'LVJIALIN' => 'https://github.com/LVJIALIN' }
    s.license      = { :type => 'WTFPL', :file => 'LICENSE' }
    
    s.platform          = :ios, '7.0'
    s.ios.deployment_target = '7.0'
    
    s.source            = { :git => 'https://github.com/GagSquad/SocialSDK.git', :tag => s.version }
    
    s.requires_arc = true
    
    
    s.subspec 'TencentOpenApiSDK' do |ss|
        ss.vendored_frameworks = 'SDK/TencentOpenApi/TencentOpenAPI.framework'
        
        ss.resources = 'SDK/TencentOpenApi/TencentOpenApi_IOS_Bundle.bundle'
        
        the_frameworks =  [
        '"SystemConfiguration"',
        '"CoreTelephony"'
        ]
        the_ldflags    = '$(inherited) -lz -lsqlite3 -liconv -lstdc++ -framework ' + the_frameworks.join(' -framework ') + ''
        
        ss.xcconfig = { 'OTHER_LDFLAGS' => the_ldflags }
    end
    
    s.subspec 'WeiboSDK' do |ss|
        ss.source_files = 'SDK/libWeiboSDK/*.{h,m}'
        ss.vendored_libraries  = 'SDK/libWeiboSDK/libWeiboSDK.a'
        
        ss.resources     = 'SDK/libWeiboSDK/WeiboSDK.bundle'
        
        ss.frameworks   = 'ImageIO', 'SystemConfiguration', 'CoreText', 'QuartzCore', 'Security', 'UIKit', 'Foundation', 'CoreGraphics','CoreTelephony'
        ss.libraries = 'sqlite3', 'z'
    end
    
    s.subspec 'WeChatSDK' do |ss|
        ss.source_files = 'SDK/WeChatSDK/*.{h,m}'
        ss.vendored_libraries = 'SDK/WeChatSDK/libWeChatSDK.a'
        
        ss.frameworks = 'Foundation', 'SystemConfiguration', 'CoreTelephony', 'CFNetwork'
        ss.libraries = 'z', 'c++', 'sqlite3'
    end
    
    s.subspec 'Core' do |ss|
        ss.source_files = 'SocialSDK/Classes/Core/Logger/**/*.{h,m}', 'SocialSDK/Classes/Core/Util/**/*.{h,m}', 'SocialSDK/Classes/Core/SocialManager/**/*.{h,m}', 'SocialSDK/Classes/Core/PlatformParamConfig/Base/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Core/Logger/**/*.h', 'SocialSDK/Classes/Core/Util/**/*.h', 'SocialSDK/Classes/Core/SocialManager/**/*.h', 'SocialSDK/Classes/Core/PlatformParamConfig/Base/**/*.h'
        ss.resources     = 'SocialSDK/Rrources/GSSocialSDKResources.bundle'
    end
    
    s.subspec 'UI' do |ss|
        ss.source_files = 'SocialSDK/Classes/UI/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/UI/**/*.h'
        ss.dependency 'SocialSDK/Core'
    end
    
    s.subspec 'QQPlatformParamConfig' do |ss|
        ss.source_files = 'SocialSDK/Classes/Core/PlatformParamConfig/QQ/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Core/PlatformParamConfig/QQ/**/*.h'
        ss.dependency 'SocialSDK/TencentOpenApiSDK'
        ss.dependency 'SocialSDK/Core'
    end
    
    s.subspec 'SinaPlatformParamConfig' do |ss|
        ss.source_files = 'SocialSDK/Classes/Core/PlatformParamConfig/Sina/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Core/PlatformParamConfig/Sina/**/*.h'
        ss.dependency 'SocialSDK/WeiboSDK'
        ss.dependency 'SocialSDK/Core'
    end
    
    s.subspec 'WeChatPlatformParamConfig' do |ss|
        ss.source_files = 'SocialSDK/Classes/Core/PlatformParamConfig/WeChat/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Core/PlatformParamConfig/WeChat/**/*.h'
        ss.dependency 'SocialSDK/WeChatSDK'
        ss.dependency 'SocialSDK/Core'
    end
    
    s.subspec 'ShareBase' do |ss|
        ss.source_files = 'SocialSDK/Classes/Share/Base/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Share/Base/**/*.h'
        ss.dependency 'SocialSDK/Core'
    end
    
    s.subspec 'QQShare' do |ss|
        ss.source_files = 'SocialSDK/Classes/Share/QQ/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Share/QQ/**/*.h'
        ss.dependency 'SocialSDK/QQPlatformParamConfig'
        ss.dependency 'SocialSDK/ShareBase'
    end
    
    s.subspec 'QzoneShare' do |ss|
        ss.source_files = 'SocialSDK/Classes/Share/Qzone/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Share/Qzone/**/*.h'
        ss.dependency 'SocialSDK/QQPlatformParamConfig'
        ss.dependency 'SocialSDK/ShareBase'
    end
    
    s.subspec 'SinaShare' do |ss|
        ss.source_files = 'SocialSDK/Classes/Share/Sina/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Share/Sina/**/*.h'
        ss.dependency 'SocialSDK/SinaPlatformParamConfig'
        ss.dependency 'SocialSDK/ShareBase'
    end
    
    s.subspec 'WeChatSessionShare' do |ss|
        ss.source_files = 'SocialSDK/Classes/Share/WeChatSession/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Share/WeChatSession/**/*.h'
        ss.dependency 'SocialSDK/WeChatPlatformParamConfig'
        ss.dependency 'SocialSDK/ShareBase'
    end
    
    s.subspec 'WeChatTimeLineShare' do |ss|
        ss.source_files = 'SocialSDK/Classes/Share/WeChatTimeLine/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Share/WeChatTimeLine/**/*.h'
        ss.dependency 'SocialSDK/WeChatPlatformParamConfig'
        ss.dependency 'SocialSDK/ShareBase'
    end

    s.subspec 'LoginBase' do |ss|
        ss.source_files = 'SocialSDK/Classes/Login/Base/**/*.{h,m,mm}'
        ss.public_header_files = 'SocialSDK/Classes/Login/Base/**/*.h'
        ss.dependency 'SocialSDK/Core'
    end

    s.subspec 'QQLogin' do |ss|
        ss.source_files = 'SocialSDK/Classes/Login/QQ/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Login/QQ/**/*.h'
        ss.dependency 'SocialSDK/QQPlatformParamConfig'
        ss.dependency 'SocialSDK/LoginBase'
    end

    s.subspec 'SinaLogin' do |ss|
        ss.source_files = 'SocialSDK/Classes/Login/Sina/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Login/Sina/**/*.h'
        ss.dependency 'SocialSDK/SinaPlatformParamConfig'
        ss.dependency 'SocialSDK/LoginBase'
    end

    s.subspec 'WeChatLogin' do |ss|
        ss.source_files = 'SocialSDK/Classes/Login/WeChat/**/*.{h,m}'
        ss.public_header_files = 'SocialSDK/Classes/Login/WeChat/**/*.h'
        ss.dependency 'SocialSDK/WeChatPlatformParamConfig'
        ss.dependency 'SocialSDK/LoginBase'
    end
    
    s.subspec 'QQ' do |ss|
        ss.dependency 'SocialSDK/UI'
        ss.dependency 'SocialSDK/QQShare'
        ss.dependency 'SocialSDK/QzoneShare'
        ss.dependency 'SocialSDK/QQLogin'
    end
    
    s.subspec 'Sina' do |ss|
        ss.dependency 'SocialSDK/SinaShare'
        ss.dependency 'SocialSDK/SinaLogin'
    end
    
    s.subspec 'WeChat' do |ss|
        ss.dependency 'SocialSDK/WeChatSessionShare'
        ss.dependency 'SocialSDK/WeChatTimeLineShare'
        ss.dependency 'SocialSDK/WeChatLogin'
    end
    
    s.xcconfig = { 'OTHER_LDFLAGS' => ' -all_load' }

    s.default_subspecs = 'UI', 'QQ', 'Sina', 'WeChat'
end
