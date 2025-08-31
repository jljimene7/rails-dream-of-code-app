################################## LESSON 3 WEEK 3 ################################

# Lets create the migration file for our new submission table

# This code defines a Rails migration for creating a new table called: submissions
# class CreateSubmissions < ActiveRecord::Migration[8.0]
#   def change
#     create_table :submissions do |t|
#       # best practice is to use [foreign_key: true] to ensure that the value in enrollment_id
#       # matches an existing table, same for lessons and mentors
#       t.references :enrollment, foreign_key: true
#       t.references :lesson, foreign_key: true
#       t.references :mentor, foreign_key: true

#       t.string :pull_request_url
#       t.string :review_result
#       t.datetime :reviewed_at

#       t.timestamps
#     end
#   end
# end

### Check the rails console after migrating:
# bin/rails db:migrate
# bin/rails console

### Rollback and re-run your migration to update the table:
# rails db:rollback STEP=1
# rails db:migrate

### If you have already created data, You need to drop and recreate the tables:
# rails db:drop
# rails db:create
# rails dv:migrate
# -----------------------------------------------------------------------------------#
################################## LESSON 3 ASSIGMENT  ###############################

# ---------------------------------------------------------------------------- #
# Q1: Tables Needed and Their Associations
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# Q2: Necessary Columns Based on the Associations Decided
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# Q3: Others Columns (If any) that must be Included on the Tables
#     What other data needs to be stored?
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# Q4: Write out each table's name and column names with data types
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# Q5: Determine the generator command you'll need to create the migration file
#     and run the command to generate the empty migration file.
# ---------------------------------------------------------------------------- #
