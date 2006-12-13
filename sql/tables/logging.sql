
--  this is the master table for all logging tables
CREATE TABLE master.logging (
    log_operation   char(1),
    log_timestamp   TIMESTAMP NOT NULL
);

