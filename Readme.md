#ATC Onboarding Controller Framework

##ATCOnboardingController

###Current

Combined and standardizes authoration tasks for camera, microphone, location, and photo library access into one library, and presents a straightforward flow to the user for each authorization requested.

###Known Issues

Location authorization requires a plist key to be set in the application.

###Planned Features

Add calendar, social networking, and other authorization types.

Add success and failure blocks for settings authorizations.

Make use of the authorization required flag to allow for potential warnings in the onboarding flow if a user declines an essential authorization.

##ATCOnboardingAuthDemo

Built as a very simple test case to show how the authorization framework behaves. It constructs a series of onboarding views to explain to the user why each permission is needed before proceeding to the next item.

It also has a secondary onboarding view for location authorization.