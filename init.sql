CREATE TABLE IF NOT EXISTS posts (
    id           BIGSERIAL,
    title        TEXT,
    body         TEXT,
    created      TIMESTAMP DEFAULT now()
  );
