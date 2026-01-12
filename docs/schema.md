Table 1 
User
columns- id:int(PK)
         email:string
         password:string


Table 2
Movie
columns- id:int(PK)
         title:string
         description:string
         release_date:datetime
         poster_url:string


Table 3
Comment
columns- id:int(PK)
         body:string
         user_id:int(FK)
         movie_id:int(FK)


Table 4
Rating
columns- id:int(PK)
         rating:int
         user_id:int
         movie_id:int

Table 5
Admin
columns- id:int(PK)
         name:string
         email:string
         password:string

Table 6
Genre
columns- id:int(PK)
         name:string