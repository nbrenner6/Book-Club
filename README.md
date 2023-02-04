# Book-Club
An app for bookworms to share their zest for literature with others.

Book Club allows users to connect with others who share their literary interests. The app implements functionality for account creation/authentication, searching for new titles, creating/joining clubs, and inviting users to clubs. Integrates back-end containing relational databases, programmed using SQLAlchemy, and routing, programmed using Flask. Utilizes Swift and UIKit to build navigatable view to navigate between functionalities and displays data using multiple UICollectionViews and UITableViews. Queries GoogleBooksAPI for search results and allows data to be stored in back-end relational databases.

Launching the app view:

<img width="273" alt="Screen Shot 2023-02-04 at 5 48 18 PM" src="https://user-images.githubusercontent.com/91486305/216792716-47715468-6961-43da-ba60-45041e0f80b3.png">

Login and create account screens integrate with back-end to authenticate inputted user info or store new user in relational databases:

<img width="267" alt="Screen Shot 2023-02-04 at 5 48 58 PM" src="https://user-images.githubusercontent.com/91486305/216792741-6c391ccb-1556-4f79-a0c8-f33e2b90ffd5.png">

<img width="274" alt="Screen Shot 2023-02-04 at 5 49 19 PM" src="https://user-images.githubusercontent.com/91486305/216792754-1ffbca71-b0cf-4b37-b962-267fac35f3d4.png">

The Reading Hub view is the central view of the app. Users can select the task they would like to complete and navigate between the corresponding views:

<img width="275" alt="Screen Shot 2023-02-04 at 5 49 42 PM" src="https://user-images.githubusercontent.com/91486305/216792763-2ddef900-32d9-473e-8f6b-bb4566eddd52.png">

The Search for Books view allows the user to enter key words to see related titles. The app queries GoogleBooksAPI to display relevant books and filters out all responses which do not contain all relevant data (images/title/author/pageCount/publishedDate):

<img width="280" alt="Screen Shot 2023-02-04 at 5 50 13 PM" src="https://user-images.githubusercontent.com/91486305/216792778-f1e69ffa-4dca-487b-838e-c7e5007eb4b9.png">

Individual books may be clicked to display further information:

<img width="281" alt="Screen Shot 2023-02-04 at 5 50 39 PM" src="https://user-images.githubusercontent.com/91486305/216792788-31162604-708c-4523-8a19-144fbb4dca95.png">

The user may then select which club to add the book to:

<img width="273" alt="Screen Shot 2023-02-04 at 5 51 48 PM" src="https://user-images.githubusercontent.com/91486305/216792821-1d191838-1fd9-4413-80d0-d3aed09a8525.png">

The My Clubs view displays the clubs in which the user is current enrolled:

<img width="276" alt="Screen Shot 2023-02-04 at 5 52 57 PM" src="https://user-images.githubusercontent.com/91486305/216792872-5b702389-70e3-4b96-b13d-e1c820fdff91.png">

Form book clubs to keep up with celebrity book clubs! Selecting a book club displays all of the club's books:

<img width="287" alt="Screen Shot 2023-02-04 at 5 53 16 PM" src="https://user-images.githubusercontent.com/91486305/216792881-9e895e05-4c0b-477d-88c7-ecf383c4d189.png">

The Invite Users view displays all the users registered on the network. Selecting one prompts the user to invite them to a specific book club they are currently in. Selecting a user filters out all clubs which the selected user is already enrolled in:

<img width="270" alt="Screen Shot 2023-02-04 at 5 53 40 PM" src="https://user-images.githubusercontent.com/91486305/216792888-970b4442-d0cd-4f5e-8b52-71857ed118e5.png">

The Join Club view filters out all clubs which the current user is already enrolled in and displays all other clubs. The user may then join the club:

<img width="279" alt="Screen Shot 2023-02-04 at 5 53 59 PM" src="https://user-images.githubusercontent.com/91486305/216792893-1b6f99a2-078a-4213-8d6a-24506f580dae.png">
