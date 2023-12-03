# twitter_clone_extended

Extended version of lab 3-4 for Mobile Devices 4100U.

## Extension Requirements
If you wish to extend this lab, you will need to add features including interaction for elements in the application.

- (done) Add a button to the AppBar that takes users to a new page where they can create a new tweet. This will require them to specify their two names, the text of the tweet, and an optional link to an image. New tweets are created with 0 comments, retweets, and likes, and are timestamped at the time of their creation.

    - This means you will need to modify your app to use timestamps instead of timestrings to indicate when a tweet was made. Do so.

- (done) Clicking the heart (Like) or retweet buttons should increase the counts by 1, and change their icons appropriately. Clicking a second time should return the count and icons to their original states.

- (done) Clicking the button next to the time string should provide a small popup that asks the user if they wish to hide the tweet. If they do so, the tweet should disappear from the feed.

- (done) Clicking the speech bubble should provide the opportunity to reply to a tweet. This should take the user to a new page where they can write a new tweet. If a tweet is submitted, it should appear in the feed directly below the original tweet, and increase the number of comments by 1.

- (done) Clicking the bookmark button should set the tweet to be a favorited tweet. Favorited tweets will always appear at the top of the feed, with any replies directly below them. Clicking the bookmark button a second time should cause the tweet to no longer be favorited.

- (done) Access a local SQLite database to generate the initial tweets that appear when starting the app. Any changes you make using the other features should be saved to the database.

- (2 mark) Add one more feature of your choice other than those listed here. Mention this feature explicitly in your README.md.

    - The feature you add should not be trivial (e.g. display the total number of tweets). As a baseline, it should be at least as complex as adding a new page that lets the user search through and display all the existing tweets containing some search term (where users should still be able to interact with those tweets as normal). 
