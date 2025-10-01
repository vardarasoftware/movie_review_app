# user - Someone who interact with the app by rating and commenting on the movies.

Table 1- User 
Model- User 
Role- simple user and admin user 
columns- 
id: int (primary Key)
name: string 
email: string
password: string 
timestamp: created_at, updated_at




# AdminUser - Someone who operates on the app by posting movies and managing the activities on the app

Table 2- AdminUser 
Model- AdminUser 
columns- 
id: int (primary key)
name: string 
email: string 
password: string 
timestamp: created_at, updated_at 




# comment - It is an action which is performed by user and has direct relationship with user and movie table.

Table 3- Comment 
Model- Comment 
columns- 
content: string 
association- belongs_to: Users and belongs_to: Movies
add_reference- Users, Movies 
(the foreign key is also added for refrential integrity)




# rating - It is the performance rate of a specific movie based on the user's rating action and has direct relationship with user and movie table.

Table 4- Rating 
Model- Rating 
columns-
 user_rating: int
association- belongs_to: Users belongs_to: Movies 
add_reference- Users, Movies
(the foreign key is also added for referential integrity)





# movie - Movie is majorly posted by admin.

Table 5- Movie 
Model- Movie 
columns- 
id: int (primary key) 
name: string 
description: string 
release_date : data type
Director : string 
Writers : string 
actors : string 
Genre : string 




# categories - the type of genre person like to watch 

Table 6- Genre 
model- genre 
columns- 
id: int (primary key)
name: string 
description: string
has_many :movie_genres
has_many :movies, through::movie_generes




Table 7- MovieGenre
model- MovieGenre
columns-
id: int (primary key)
movie_id: int
genre_id: int




# mermaid  

erDiagram
    USER {
        int id PK
        string name
        string email
        string password
        datetime created_at
        datetime updated_at
    }

    ADMINUSER {
        int id PK
        string name
        string email
        string password
        datetime created_at
        datetime updated_at
    }

    COMMENT {
        int id PK
        string content
        int user_id FK
        int movie_id FK
    }

    RATING {
        int id PK
        int user_rating
        int user_id FK
        int movie_id FK
    }

    MOVIE {
        int id PK
        string name
        string description
        date release_date
        string director
        string writers
        string actors
        string genre
    }

    GENRE {
        int id PK
        string name
        string description
    }

    MOVIEGENRE {
        int id PK
        int movie_id FK
        int genre_id FK
    }

    %% Relationships
    USER ||--o{ COMMENT : "writes"
    MOVIE ||--o{ COMMENT : "receives"

    USER ||--o{ RATING : "gives"
    MOVIE ||--o{ RATING : "has"

    ADMINUSER ||--o{ MOVIE : "posts"

    MOVIE ||--o{ MOVIEGENRE : "categorized"
    GENRE ||--o{ MOVIEGENRE : "assigned"



