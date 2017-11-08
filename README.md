# Sinatra Portfolio Project - Euro Mountaineering

This project implements a CRUD application using Sinatra and ActiveRecord.

Euro Mountaineering is a website for people who climb mountains. It allows a hiker to create a user account. With the user account the hiker can track his or her progress in climbing the major mountains in Europe. The many mountains of Europe each have an entry with some basic data about the mountain. Hikers are organized into clubs. The clubs track the overall achievements of their members.

## Models

There are three main models used and a fourth linking model.

* Hiker
* Mountain
* Club
* Hiker_Mountains

## Controllers

There are two main controllers used as well as the application_controller

* application_controller
* mountains_controller
* hikers_controller