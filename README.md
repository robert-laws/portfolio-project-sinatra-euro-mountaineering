# Sinatra Portfolio Project - Euro Mountaineering

This project implements a CRUD application using Sinatra and ActiveRecord.

Euro Mountaineering is a website for people who climb mountains. It allows a hiker to create a user account. With the user account the hiker can track his or her progress in climbing the major mountains in Europe. The many mountains of Europe each have an entry with some basic data about the mountain. Hikers are organized into clubs. The clubs track the overall achievements of their members.

# Entity Relationship Diagram

The database relationships are based on the ERD model. There are ``hikers`` that belong to a ``club`` and have many hikes - described by ``hiker_mountains``. Each ``hiker_mountains`` belongs to a hiker, which can have many hikes. Finally, there are a number of ``mountains`` that can be hiked. The ``mountains`` belong to the hikes.

![Entity Relationship Diagram](https://github.com/robert-laws/portfolio-project-sinatra-euro-mountaineering/blob/master/public/images/erd_sinatra_project.jpg)

# Installation

In order to install this application, follow these steps:

* fork the repository to your local development environment
* run the ``bundle install`` command to install dependencies
* run the ``rake db:migrate`` command to install the database and database schema
* add starter data to the database by running the ``rake db:seed`` command
* to preview the application, use the command ``shotgun`` to initiate a local server

# Contributing

Please see the [Contributing Guide](CONTRIBUTING.md) for more information about how to contribute to this project.