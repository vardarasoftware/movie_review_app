# user - Someone who operate on the app by commenting and rating on the particular movies.

Table 1- User 
Model- User 
Role- simple user and admin user 
columns- id:string (primary Key), 
         email:string, 
         password:string 


# comment - It is an action which is performed by user and has direct relationship with user and movie table.

Table 2- Comment 
Model- Comment 
columns- user_comment: string 
association- has_many: Users, Movies
add_reference- Users, Movies 
(the foreign key is also added for refrential integrity)


# rating - It is the performance rate of a specific movie based on the user's rating action and has direct relationship with user and movie table.

Table 3- Rating 
Model- Rating 
columns- user_rating: int
association- has_many: Users, Movies 
add_reference- Users, Movies
(the foreign key is also added for referential integrity)


# movie - Movie is majorly posted by admin.

Table 4- Movie 
Model- Movie 
columns- name: string (primary key)
         description: string 
         release_date : int 
         Director : string 
         Writers : string 
         Stars : string 
         Genre : string 


# Associations - using has_many majorly to connect comment and rating table to user and movie. 


