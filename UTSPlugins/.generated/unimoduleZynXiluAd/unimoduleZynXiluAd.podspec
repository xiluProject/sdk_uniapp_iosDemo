Pod::Spec.new do |s|
  s.name = 'unimoduleZynXiluAd'
  s.version = '1.0.0'
  s.summary = 'uni-app UTS plugin zyn-xiluAd.'
  s.author = { 'DCloud' => 'dev@dcloud.io' }
  s.homepage = 'https://www.dcloud.io/'
  s.license = { :type => 'MIT' }
  s.platform = :ios, '12.2'
  s.source = { :path => '.' }
  s.source_files = ['src/**/*.{h,m,mm,swift,c,cc,cpp}', 'DCloudUTSConfig.{h,m}', 'UTSCPP.{h,mm}']
  s.resources = ['Resources/*', 'config.json', 'PrivacyInfo.xcprivacy']
  s.vendored_frameworks = 'Frameworks/**/*.{framework,xcframework}'
  s.vendored_libraries = 'Libs/**/*.a'
  s.dependency 'uniapp/Core'
  s.dependency 'xiluAdSdk'
end
