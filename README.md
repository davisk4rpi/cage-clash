Coming to the App Store and Google Play soon!

# Cage Clash

Cage Clash is a game that has you predict UFC fight outcomes for points and compete against friends.

Every UFC Event information is loaded into the app and players make predictions for each fight on the main card. The player must choose the `Winner`, `Method` of victory, and `Round` that the fight will end. Additionally the player can place a `Confidence` wager from 1-5. 

## Scoring

### If player picks the _incorrect_ `Winner` 
They score 0 points for the fight and lose the number of `Confidence` points they wagered

### If player picks the _correct_ `Winner`
They score 1 point for picking the winner and win the number of `Confidence` points they wagered
- If the player also correctly picks `Decision` as the `Method`, they gain an additional 2 points.
- If the player correctly picks any other `Method`, they gain an additional 1 point.
- If the player correctly picks the `Round`, they will gain 1 point for each round (1-5 points) ** `Decision` picks do not include rounds


## Development
### Current Tech
Typescript, Expo, React Native, Redux Toolkit, Firebase, React Navigation, React Native Paper, Yarn Workspaces

### Planned Tech Integrations
#### Jest & Detox
 - Initialize Jest for unit testing
 - Initialize Detox for RN E2E testing
#### Github Actions
 - Code evalution with eslint
 - Unit Testing with Jest
 - Trigger React Native E2E testing with Detox on private runner
 - App Deployment to App Store Connect and the Play Console

### Planned Features
- NEXT: View scores and compare with other players
- Create more yarn workspaces from code with the `app` workspace
- User Onboarding with customization
- NO SPOILERS feature to prevent unsuspected fight outcomes from ruining your day
- Create a private league for you and your friends
- Automated Production seeding of fight information before and after an event occurs
- Populate app with Vegas betting odds using web scraping or apis

