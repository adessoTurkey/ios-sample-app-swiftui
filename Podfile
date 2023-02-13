platform :ios, '15.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'SampleAppSwiftUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for boilerplate-ios-swiftui

  # Utils
  pod 'CocoaDebug', :git => 'https://github.com/philosopherdog/CocoaDebug.git' , :configurations => ['Development','Swifter']

  target 'SampleAppSwiftUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SampleAppSwiftUIUITests' do
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end

end
