CREATE TABLE blogs (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  description VARCHAR(50) NOT NULL,
  created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
