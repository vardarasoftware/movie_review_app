# Movie Rating App - Database Schema Design

This document describes the initial database schema for our Movie Rating web application. The goal is to keep things simple but scalable, similar to IMDB in concept, while supporting both admin and normal users.

## Users

We will have two types of users: admins and normal users. Admins will manage movies and categories, while normal users will be able to rate and comment on movies.

**Fields**

- id (primary key)
- name: string
- email: string (unique)
- password: string (secure)
- role (enum: admin or user, default user)
- timestamps

## Movies

Movies can only be created by admins through the admin panel. Each movie has a title, description, and other details like release date, director, and writer. (We are make simple for now, movies data only uploaded by the admin side only)

**Fields**

- id (primary key)
- title: string
- description: text
- release_date: date
- director: string
- writer: string
- banner: string (for storing image path or Active Storage reference)
- timestamps

\*\*Since movies can belong to more than one category (e.g., Action + Adventure + Drama), we will handle this through a join table.

## Categories

Categories define the genre of a movie (e.g., Action, Comedy, Drama).

**Fields**

- id (primary key)
- name (unique, required)
- timestamps

## MovieCategories (Join Table)

Because movies can belong to multiple categories, we’ll use a join table to connect `movies` and `categories`.

**Fields**

- id (primary key)
- movie_id (foreign key to movies)
- category_id (foreign key to categories)
- timestamps

## Ratings

A user an give one rating per movie, with value between 1 and 5.

**Fields**

- id (primary key)
- user_id (foreign key to users)
- movie_id (foreign key to movies)
- rating: integer (required, 1–5)
- timestamps

## Comments

Users can leave comments on movies. Each comment is tied to both the user who wrote it and the movie it belongs to.

**Fields**

- id (primary key)
- user_id (foreign key to users)
- movie_id (foreign key to movies)
- content: text (required)
- timestamps

## Relationships Overview

- A **User** has many ratings and comments.
- An **Admin** can create movies and categories.
- A **Movie** has many comments and ratings, and it belongs to many categories through the join table.
- A **Category** can be linked to many movies through the join table.
- A **Rating** belongs to a user and a movie.
- A **Comment** belongs to a user and a movie.

---

---

```mermaid
erDiagram

USERS {
int id PK
string name
string email
string password_digest
string role
datetime created_at
datetime updated_at
}

MOVIES {
int id PK
string title
text description
date release_date
string director
string writer
string banner
datetime created_at
datetime updated_at
}

CATEGORIES {
int id PK
string name
datetime created_at
datetime updated_at
}

MOVIE_CATEGORIES {
int id PK
int movie_id FK
int category_id FK
datetime created_at
datetime updated_at
}

RATINGS {
int id PK
int user_id FK
int movie_id FK
int rating
datetime created_at
datetime updated_at
}

COMMENTS {
int id PK
int user_id FK
int movie_id FK
text content
datetime created_at
datetime updated_at
}

USERS ||--o{ RATINGS : gives
USERS ||--o{ COMMENTS : writes
MOVIES ||--o{ RATINGS : receives
MOVIES ||--o{ COMMENTS : has
MOVIES ||--o{ MOVIE_CATEGORIES : categorized_by
CATEGORIES ||--o{ MOVIE_CATEGORIES : categorizes
```
