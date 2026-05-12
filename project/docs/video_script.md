# video script:

* opening section
    your project’s title;
    your name;
    your GitHub and edX usernames;
    your city and country;
    and, the date you have recorded this video.

Welcome.
My name is Diego Couto, nullspace on github, I'm studying software development here Querétaro México and, at the time of filming this, it's the 10th of May 2026.
 
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

    - main tables

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
