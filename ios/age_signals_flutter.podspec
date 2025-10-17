#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint age_signals_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'age_signals_flutter'
  s.version          = '0.0.2'
  s.summary          = 'Flutter plugin to access Google Play Age Signals (Android) and Apple Declared Age Range API (iOS).'
  s.description      = <<-DESC
Flutter plugin providing unified access to Google Play Age Signals (Android) and Apple Declared Age Range API (iOS)
for enabling age-appropriate app experiences and digital safety compliance.
  DESC
  s.homepage         = 'https://github.com/neeleshsahu290/flutter_age_signals_api'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Neelesh Sahu' => 'neelesh.sahu@tailnode.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency       'Flutter'
  s.platform         = :ios, '13.0'

  # Exclude unsupported simulator architecture
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }

  s.swift_version = '5.0'

  # Optional: Include privacy manifest if required later
  # s.resource_bundles = {
  #   'age_signals_flutter_privacy' => ['Resources/PrivacyInfo.xcprivacy']
  # }
end
