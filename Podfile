source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

target 'LibTrack' do
    pod 'Nuke'
    pod 'IQKeyboardManagerSwift'
    pod 'Alamofire'
    pod 'Firebase/Auth'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'GoogleSignIn'
    pod 'ESPullToRefresh'
    pod 'FTIndicator'
    pod 'DTPhotoViewerController'
    pod 'SwiftLint'
    pod 'SnapKit'
    pod "HTagView"

    post_install do |pi|
        pi.pods_project.targets.each do |t|
          t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          end
        end
    end

		target 'LibTrackTests' do
        inherit! :search_paths
        pod 'Firebase'
    end
end

