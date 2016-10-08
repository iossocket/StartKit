# StartKit

### Admin

### Setup Development Env

* Install Xcode 8
* Install rbenv
* Install Carthage

	```
	brew install carthage
	```
* Install Fastlane

	```
	gem install fastlane --verbose
	```
* Install and Config SwiftLint

	```
	brew install swiftlint
	```

### Init Project
* Clone the iOS StartKit Repo

	```
	git clone https://github.com/iossocket/StartKit.git
	note: we will move it to a ThoughtWorks private repo later.
	```

* Install Carthage, and then run:

	```
	carthage update --platform iOS
	```

### Setup Jenkins

1. Install Jenkins

	```
	Download jenkins.war from https://jenkins.io/
	```

2. Start Jenkins

	```
	java -jar jenkins.war
	```

3. Install required Jenkins plugins: `Pipeline` and `Git Plugin`

	`Manage Jenkins` -> `Manage Plugins`

4. Generate Credential

	`Credentials` -> `Global credentials` -> `Add Credentials`

5. Create new project

	`New Item` -> Choose `pipeline style`

6. Configure project

	Configure `Build Triggers` -> Choose Pipeline defination `Pipleline script from SCM` -> Fill the form with the created credential.
	

### About StartKit
* Use Swift 3.0;
* Architecture MVVM;
* Use Carthage to manage dependencies;
* Required 3rd part library: Alamofire, Kingfisher, ObjectMapper, SnapKit, SVProgressHUD;
* SwiftLint to enforce Swift style and conventions;
* Security scan: Danger;
* Use Jenkins as CI;
* Use fastlane as build and package tool;
* AdHoc publish use HockeyApp.

