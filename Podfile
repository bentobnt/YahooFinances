# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

flutter_application_path = 'yahoo_finances_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'YahooFinances' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  install_all_flutter_pods(flutter_application_path)

  # Pods for YahooFinances
  pod 'SnapKit'

end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
