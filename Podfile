source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

workspace 'MyApp.xcworkspace'

target 'MyApp' do
    project 'MyApp'
    
    pod "XCDYouTubeKit", "~> 2.12"
    
    pod 'SDWebImage', '~> 5.0'
    
    pod 'RealmSwift'

    # Architect
    pod 'MVVM-Swift' # MVVM Architect for iOS Application.

    # Data
    pod 'ObjectMapper' # Simple JSON Object mapping written in Swift. Please fix this version to 2.2.6 now.

#target 'MyAppTests' do
#    inherit! :complete
#end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Release'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            end
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
        end
    end
end
