# DevOps Test

This git repository contains a hopelessly outdated version of a docker environment for a simple php website with database access.

To make sure we do not change the current functionality of the website the upgrade should be done in multipe phases.
There would be a "code review" of each phase, so please make sure a colleague who is somewhat familiar with the setup can follow your changes.

## Phase 1: Get the Docker Env to work

In the current state the docker environment does not build and some dependencies are missing.
Tag the result of this phase `phase_1`.

## Phase 2: Upgrade versions

Make sure we are not running outdated software versions.
This phase should be based on `phase_1`, tag it's result `phase_2`.

## Phase 3: Database Backups

There is shell script that create database backups by running
`docker exec -u root db-container backup`.
We always wanted to improve it so that it keeps dumps of the last 7 days, then one weekly dumps of the last 4 weeks and a monthly dump for the last 6 months.
This script does not need to be fancy, we just want to see how you approach this task.
The result of this phase should be in a `backup_script` branch.

## Phase 4: Improvements

The environment is not very nice, improve whatever you like.
This phase should be based on `phase_2`.
