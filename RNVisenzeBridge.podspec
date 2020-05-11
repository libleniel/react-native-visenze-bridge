
require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platforms    = :ios, "9.0" 

  s.requires_arc = true
  s.source       = { :git => "https://github.com/libleniel/react-native-visenze-bridge", :tag => "v#{s.version}" }
  s.source_files  = "ios/*.{h,m}" , "ios/ViSearchSDK/*.{h,m}"

  s.dependency 'React'
end

  