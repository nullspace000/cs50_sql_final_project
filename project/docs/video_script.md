# video script:

* opening section
    your project’s title;
    your name;
    your GitHub and edX usernames;
    your city and country;
    and, the date you have recorded this video.

Welcome.
My name is Diego Couto, **show github**, I'm currently wrapping up my third semester of software development here Querétaro México and at the time of filming this, it's the *th of May 2026.
 
This is the video overview of my final project for the harvard cs50 introduction to sql course.
But, before we start, I quickly want to say thank you. I had an absolute blast solving the exercises and learning about how sql databases work. So much so that databases are now my favorite part of development. I can tell that tons of time and care were put into designing this course. So, thank you for making it and for making it available to all of us.

## 1. idea
    
    * explain idea
    The idea that I landed on in the end was to represent local soccer leagues. I chose this one becuase I wanted something that I could apply to real life, something that I could scale and tourn into a service if I wanted to, and my brothers and many of my friends play in these small leagues and have expressed interest multiple times in an app to manage them. So I just put two and two together.

## 2. my project
    So, this is my project.
    * zoom into the top 
    And this top part is the heirarchy diagram that represents the overall structure. 
    So, there are tournaments in leagues, matches and teams in tournaments, match_events in matches and players, trainers and referees in teams.

    I'm actually really proud of this diagram. Making it really tickled my brain. 
    It represents the schema **show_schema** with way more detail than a normal entity relationship diagram. 
    I made it like this because, After I decided on the idea, I was having trouble planning and keeping track of all of the relationships. So this is where most of the actual designing took place.
    **show old diagram** This is how it looked when I started. As you can see, I was quite confused.

### explain main user flow

Anyhow, the best way to explain how all of these tables work together is be by going through the user flow I developed in the queries.sql file. Only the most important ones though.

The hypothetical case is: Bob is an avid soccer player and want to host a league in Florida.

- First, the user creates their user account with their email and password. The users table is the backbone of my database, since everyone represented in it, including players, trainers, referees and admins all stem from their user account. 

- for example, here the user bob@gmail.com becomes a player. This is where he inputs the data you would want to know about a player like his **look at player attributes in diagram** Trainer and refere registration works exactly the same.

- next, creates a team called bobs team. this is where he states the teams name, bio, and some other details. He is also added as the team admin for creating it in the teams_admins joining table. All of these red tables at the bottom are joining tables, meaing they represent many to many relationships. This is a bit more obvious in the next query.

- here, bob adds a player called rosa becker to his team. The reason why we need a joining table for this is becuase teams have many players and players could be in more than one team. **show teams_players_view** I wrote a view for each joining table to make them easyer to use. 

- ** select:--  Add trainers to their team.--  Add other administrators to their team.**
next bob adds a trainer and an administrator to his team, making use of the leagues_admins and teams_trainers joining tables. Adding trainers works the same way as adding players and the only difference with adding administrators is that there is no admins table, since its not necesarry. So the teams_admins table simply references user accounts.

- Lets say bob has added a bunch more people to his team and now he want to create the league. He calls it bobs grand florida league and specifies the description and general location aswell.

- Now he must create the first tournament to get the league going. So he creates 'Tournament #1',
sets the status to    'Ongoing',
the season to    '2026',
the format to    'Knockout', 
the start date to 28 of may    '28.05',
the end date three months latter on august 28    '28.08',
the maximum number of teams to    20,
and the entry fee to    '50$' dollars per team

- Next, Iron Vanguard and his own team to the tournamen #1 and now that he has two teams, he can create the first match with this query. He sets the location to the 'Iron Vanguard Soccer Gym' and the date to the '03.jul.2026'

- Bob also adds the referee Noah Bakker to the match through the matches_referees joining table.

- If we jump foreward in time a bit, bob is now starting the match by changing the status to Ongoing.

- A couple of minutes into the match, Marco Osei from the rival team scores a goal. For this, I made the match_events table. 
One of the referees registers the event with the match the event happened in (identified by the date and the teams),
he must also include Marco Osei as the player, his team the iron vanguard, the event type as goal and reference himself as the responsible referee for registering the event. In this case, it was Noah Becker.
**show event in view** There it is in our databse!!
match events can also represent faults, yellow and red cards at the moment.

- And just like that, we have used all of the tables. Reading the schema and the design.md files should be much easyer with this context.

- I will continue to develop this app. I think its a really good proyect to develop while I'm learning.
There are still tons of details to fix and specify but, this is about as far as i can get before making the mockup for the app and establishing all of the user flows. And after I have those, I will probably move to a database that supports specific datatypes, simultaneous writes and prepared statements like mariaDB. Or at least, thats my paln for now.

Thank you for your attention.

and thank you for making the course? if i still have time





################
old
###############


        Now, I know I went a bit big. The scope did get out of hand but, in my defence, it look really simple in my diagram.
        I also kept comming up with ideas and going 'oh, i could add this! i could change that! 
        And this has been my life between classes for the last three months.
        I will continue to develop this database for the app. I think its a really good proyect to develop while I'm learning. 
But, for the purpose of this final proyect, I believe it's in a worthy state for submition.
    
## 2. diagram
    After I decided on this local soccer league idea
    I was having trouble designing
    So, as always, I made a diagram.
    - diagram progression
        I'm really proud of this diagram.
        Making it really tickled my brain. And this is where most of the actual designing of the database took place.
        It really helped me visualize where the tables would relate with one-another.
        This it how it started out if you are curious. As you can see, the main tables are here but I was quite confused about the relationships and how to represent them.
    - joining tables
        The hardest part was understanding these joing tables at the bottom. You see 
        "I was stuck for a good week, trying to understand how the many to many relationships would work in the database while I worked on other things,  untill I asked my profesors and he walked me through why and how we have to represent many to many relationships with a table of their own and then it made complete sence"
    - seeding:
        Once I was happy with the state of the schema, I started writing some of the queries a user would run. But, I got frustrated with the fact that I didn't have any data to test my queries on.
        So, I went on a seeding side quest.
        Not completley necesarry. But, I wanted to use what I learned about importing csv files in week 3. 

    - views: 

## X. next steps to build the mobile app

I have never built a full app before. So, I'm still figuring out what the process looks like.
But, if I were to go with my gut, the step that makes the most sence would be to... 
- design the mockup of the app and the user flows to get a better idea of the features that I will need.
And after that, maybe migrating to a database that can handle multiple writes at the same time and has more specific datatypes like mariaDB but I'm not really sure yet.
- move to postgress / mariadb
