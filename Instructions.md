# iOS Code Challenge Instructions

Thank you for applying for a iOS position at SoundCloud.
We ask engineering candidates to work and complete this code challenge.
Your submission is part of the basis upon which we evaluate your candidacy.

We hope it's indeed challenging (and maybe even fun).

The challenge focuses on **refactoring** an existing **iOS application**.

Our aim with these instructions is to leave no doubt about the details of the challenge and the expectations of
your submission - however, if you have questions of any sort _please ask_.

Also: please read all of the instructions before starting!

## Time Expectations

Based on internal testing, we roughly estimate the challenge will take
somewhere around 4-8 hours of your time.

* Our goal for this time budget is to keep the time investment predictable for candidates - it is not intended to create significant "time pressure".
* The length of time you take to submit your work is not a factor in how we review it.

## Discretion

In order to ensure continued fairness to all past and future participants,
please do not share any of the details of this code challenge with others,
including the work you submit.

## Anonymity

Please help us by keeping your submission free of information that would be revealing of who you are, or any personal attributes.

- Remove references in comments on top of files
- Remove the <project_name>.xcodeproj/xcuserdata folder
- Don't add any links into the README that could help to identify you
- Make sure there is no team or other identifiers set in the project files
- If you use git, please anonymize your author name using e.g. git config --global anonymous "someone@anonymous.com"

# iOS Challenge

### Specification

We deliberately avoid giving detailed specs for how the application currently works. Part of the assessement will be how well you have understood & maintained the current behaviour while refactoring.

We think that a good solution is one which clearly expresses what the application currently does, while leaving open the potential for future changes to its functionality.

Details of the `/playlists/{playlist_id}` endpoint are documented in our public API and can be found [here](https://developers.soundcloud.com/docs/api/explorer/open-api#/playlists/get_playlists__playlist_id_).

### Goals

The **primary goals** for this exercise (i.e. things we will directly assess) are:
* To provide structure and clarity to the project by introducing appropriate abstractions. (While designing for robustness can lead to many layers of abstraction, we recommend you focus on the single use case the app has at the moment. i.e. try not to over-engineer your solution.)
* To unit test your networking code.
* To ensure that the rest of the code is testable (regardless of whether or not you write tests for it.)
* To document your approach in a README file. Please also include details of further changes you would make to ensure the code is "production ready."

Some **anti-goals** for this exercise (i.e. things you should not do) are:
* To introduce third-party dependencies to the codebase.
* To implement any new functionality, or change the existing functionality.

In addition, please consider the following points as **non-goals** (i.e. their absence will not factor into our decision):
* To implement the solution with **Swift UI**
* To make the solution entirely production-ready.
* To achieve full unit test coverage.

# Deliverables

When you are done, send us an archive containing:
* Your refactored version of the code.
* A README file detailing for approach and architectural decisions.

_Remember: unit tests are required ONLY for the networking part._
