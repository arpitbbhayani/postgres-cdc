SELECT pg_create_logical_replication_slot('cdc_slot', 'wal2json');


SHOW wal_level;
ALTER SYSTEM SET wal_level = logical;
SHOW wal_level;

INSERT INTO users(id, name, email, bio) values (1, 'arpit', 'arpit@gmail.com', 'CS Engineer, Educator, and Polyglot');
SELECT * FROM pg_logical_slot_peek_changes('cdc_slot', NULL, NULL);
SELECT * FROM pg_logical_slot_get_changes('cdc_slot', NULL, NULL);
INSERT INTO users(id, name, email, bio) values (2, 'arpit', 'arpit@gmail.com', 'CS Engineer, Educator, and Polyglot');
SELECT data FROM pg_logical_slot_get_changes('cdc_slot', NULL, NULL);

CREATE TABLE public.users1 (
  bio character varying(255) NULL,
  email character varying(255) NOT NULL,
  name character varying(255) NULL,
  created_at timestamp without time zone NOT NULL DEFAULT NOW(),
  id integer NOT NULL
);
ALTER TABLE
  public.users1
ADD
  CONSTRAINT users1_pkey PRIMARY KEY (id)
 
INSERT INTO users1(id, name, email, bio) values (1, 'arpit', 'arpit@gmail.com', 'CS Engineer, Educator, and Polyglot');

SELECT * FROM pg_logical_slot_peek_changes('cdc_slot', NULL, NULL, 'filter-tables', 'public.users');

