#!/usr/bin/bash

rm soccer_leagues_db
cat schema.sql | sqlite3 soccer_leagues_db
# cat seeding/seeding.sql | sqlite3 soccer_leagues_db
cat queries.sql | sqlite3 soccer_leagues_db

