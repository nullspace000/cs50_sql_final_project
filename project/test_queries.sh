#!/usr/bin/bash

bash rebuild_database.sh
cat queries.sql | sqlite3 soccer_leagues_db
sqlite3 soccer_leagues_db