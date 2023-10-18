# wikipedia-locations

Test assignment for ABN AMRO iOS Developer position

## Table of Contents

- [Assignment Description](#project-description)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Notes for Reviewers](#notes-for-reviewers)

## Assignment Description

Clone the Wikipedia app from GitHub (https://github.com/wikimedia/wikipedia-ios). The Wikipedia app can be called from other apps via deep linking.
Modify the Wikipedia app so that it can be called in a way so that, when started, it directly goes to the ‘Places’ tab and shows the location specified by the calling app (e.g. via coordinates), instead of the current location.

Create a simple test app with a list of locations. Your app should fetch locations from https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json
Tapping on a location should call the Wikipedia app in this new way to demonstrate the functionality. 
The user of the test app should be allowed to enter a custom location and open the Wikipedia app there.

**Assignment requirements**:
Work locally and perform your changes locally (but still using git). Once done, share a public GitHub link with me.

## Prerequisites

1. Clone the repo with the modified Wikipedia app: https://github.com/lokapodo/wikipedia-ios
2. Run the Wikipedia app 

## Installation

Minimum supported iOS: 17.0

- Clone the repo and run the project :)

## Notes for Reviewers

- The code is not 100% covered by tests. For the production app, more test cases should be covered.
- Validation of entered lat and lon could be improved to avoid redirects to the Wikipedia app with invalid coordinates.
- The network service is simplified according to the assignment's needs.
- Error handling could be improved by creating custom errors and providing user-friendly messages for different errors.
- All commits were pushed to the main branch, without creating separate branches.
