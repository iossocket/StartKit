require 'cucumber'
require 'appium_lib'
require 'appium_lib/driver'

Before do |scenario|
  ios_simulator = {
      'appium-version' => '1.6.0-beta3',
      'platformName' => 'iOS',
      'platformVersion' => '10.0',
      'deviceName' => 'iPhone 6',
      'app' => '../Build/StartKit.app',
      'noReset' => false
  }

  Appium::Driver.new(caps: ios_simulator).start_driver
  Appium.promote_appium_methods Object
end

After do |scenario|
  # driver_quit
end