# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ReduxForSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ReduxForSwift
  pod 'ReactiveRedux',
    git: 'https://github.com/protoman92/ReactiveRedux-Swift.git',
    subspecs: [
      'Main',
      'SimpleStore',
      'UI',
      'Middleware',
      'Middleware+Router',
      'Middleware+Saga'
    ]
    
  target 'ReduxForSwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
