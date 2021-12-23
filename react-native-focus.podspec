require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-focus"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/Gustash/react-native-focus.git", :tag => "#{s.version}" }
  
  s.source_files = "ios/Shared/**/*.{h,m,mm}"
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files = "ios/Core/**/*.{h,m,mm}"
    ss.dependency "React-Core"
  end

  s.subspec "Extension" do |ss|
    ss.source_files = "ios/Extension/**/*.{h,m,mm}"
    s.frameworks = "Intents"
  end
end
