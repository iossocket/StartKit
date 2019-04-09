fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios add_devices
```
fastlane ios add_devices
```
Add testing devices. Run by the codebase manager.
### ios prepare
```
fastlane ios prepare
```
Clear build folder and update carthage.
### ios carthage_update
```
fastlane ios carthage_update
```
Update carthage
### ios clear_build_files
```
fastlane ios clear_build_files
```
Clear build files.
### ios lint
```
fastlane ios lint
```
Code stype check
### ios run_test
```
fastlane ios run_test
```
Run all tests on iPhone 6.
### ios checkin
```
fastlane ios checkin
```
Checkin. Run this everytime before git push.
### ios build
```
fastlane ios build
```
Build for ad-hoc
### ios deploy_beta
```
fastlane ios deploy_beta
```
Deploy beta to hockeyapp
### ios beta
```
fastlane ios beta
```
Test, build and deploy beta to hockeyapp

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
