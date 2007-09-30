
CREATE OR REPLACE FUNCTION auth.hash_password( password TEXT ) RETURNS TEXT AS $$
  DECLARE
    binary_salt BYTEA;
  BEGIN
    SELECT INTO binary_salt gen_random_bytes(8);
    RETURN encode(binary_salt, 'hex'::text) || md5(binary_salt||textsend(password));
  END;
$$ LANGUAGE plpgsql;

