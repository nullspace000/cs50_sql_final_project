#!/usr/bin/bash

rm soccer_leagues_db
cat schema.sql seeding/seeding.sql | sqlite3 soccer_leagues_db
