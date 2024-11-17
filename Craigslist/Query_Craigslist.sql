\c craigslist_db


-- The region of the craigslist post
SELECT nickname user,
    title,
    city region
FROM post
    JOIN region ON region_id = region.id
    JOIN profile ON profile_id = profile.id;

-- Users and preferred region
SELECT nickname user,
    city preferred_region
FROM profile
    JOIN region ON region_preferred = region.id;

-- Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting
SELECT title,
    content,
    nickname user,
    location,
    city region
FROM post
    JOIN profile ON profile_id = profile.id
    JOIN region ON region_id = region.id; 

 -- Categories that each post belongs to
SELECT
    title AS post_title,
    tag AS categories
FROM post
    JOIN post_category pc ON post.id = post_id
    JOIN categories body ON category_id = body.id;