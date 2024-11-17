\c craigslist_db

INSERT INTO region (id, city) VALUES 
(1, 'San Francisco'), 
(2, 'Atlanta'), 
(3, 'Seattle');

INSERT INTO profile (id, nickname, region_preferred) VALUES 
(1, 'Bluey', 1),
(2, 'Luis', 2);

INSERT INTO post (id, title, content, profile_id, region_id, location) VALUES 
(1, 'Selling Crayons', 'Crayons are in good conditions. Very loved, used little.', 1, 1, 'Downtown SF'),
(2, 'Looking for roommates', 'Two rooms are now available, contact me for information.', 2, 2, 'Midtown Atlanta');

INSERT INTO categories (id, tag) VALUES 
(1, 'For Sale'),
(2, 'Stationery'),
(3, 'Housing'),
(4, 'Roommate');

INSERT INTO post_category (post_id, category_id) VALUES 
(1, 1), -- Post 1 is tagged as 'For Sale'
(1, 2), -- Post 1 is also tagged 'Stationery'
(2, 3), -- Post 2 is tagged as 'Housing'
(2, 4); -- Post 2 is also tagged 'Roommate'
