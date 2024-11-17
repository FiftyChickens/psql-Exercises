DROP DATABASE craigslist_db;
CREATE DATABASE craigslist_db;
\c craigslist_db

CREATE TABLE "region" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "city" TEXT NOT NULL
);

CREATE TABLE "profile" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "nickname" TEXT NOT NULL,
    "region_preferred" INT,
    CONSTRAINT "fk_profile_region_preferred" FOREIGN KEY ("region_preferred")
    REFERENCES "region" ("id") ON DELETE SET NULL
);

CREATE TABLE "post" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "profile_id" INT NOT NULL,
    "region_id" INT NOT NULL,
    "location" TEXT NOT NULL,
    CONSTRAINT "fk_post_profile_id" FOREIGN KEY ("profile_id") REFERENCES "profile" ("id") ON DELETE CASCADE,
    CONSTRAINT "fk_post_region_id" FOREIGN KEY ("region_id") REFERENCES "region" ("id") ON DELETE CASCADE
);

CREATE TABLE "categories" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "tag" TEXT NOT NULL
);

CREATE TABLE "post_category" (
    "post_id" INT NOT NULL,
    "category_id" INT NOT NULL,
    CONSTRAINT "pk_post_category" PRIMARY KEY ("post_id", "category_id"),
    CONSTRAINT "fk_post_category_postid" FOREIGN KEY ("post_id") REFERENCES "post" ("id") ON DELETE CASCADE,
    CONSTRAINT "fk_post_category_category_id" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE CASCADE
);