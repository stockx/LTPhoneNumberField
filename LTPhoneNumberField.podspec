Pod::Spec.new do |s|
  s.name             = "LTPhoneNumberField"
  s.version          = "0.1.0"
  s.summary          = "A UITextField subclass that formats a phone number as you type."
  s.description      = <<-DESC
                       LTPhoneNumberField is a subclass of UITextField that dynamically formats a phone number as it is typed by the user.

                       * Locale-agnostic
                       * Delegates phone number parsing to libPhoneNumber
                       DESC
  s.homepage         = "https://github.com/getlua/LTPhoneNumberField"
  s.license          = 'MIT'
  s.author           = { "Colin Regan" => "colin@getlua.com" }
  s.source           = { :git => "https://github.com/getlua/LTPhoneNumberField.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/khaullen'

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.dependency 'libPhoneNumber-iOS', '~> 0.7.2'
end
