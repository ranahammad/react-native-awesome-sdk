require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "react-native-awesome-sdk"
  s.version      = package["version"]
  s.summary      = package["description"] || "React Native wrapper for Awesome SDK"
  s.license      = package["license"] || "MIT"
  s.authors      = package["author"] || { "Rana Hammad" => "rana.hammad@live.com" }
  s.homepage     = package["homepage"] || "https://github.com/ranahammad/react-native-awesome-sdk"
  s.platforms    = { :ios => "12.0" }

  s.source       = { :git => "https://github.com/ranahammad/react-native-awesome-sdk.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React-Core"
end
