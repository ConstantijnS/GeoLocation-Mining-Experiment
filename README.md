GeoLocation-Mining-Experiment
=============================

Experiment in 'mining' points based on Geolocation movement

Summary:
In this code I tried to create a structured way of calculating points based on changes in geolocation.
Latitude and Longitde changes are used to calculate 'gamepoints'. These gamepoints can then be used for a 
variety of purposes.
For testing purposes the gamepoints are turnbased 'consumed' by a ConsumerUnit object.

Structure:
To avoid overloading the MainViewController all communication between the Model (Model-View-Controller) and
the MainViewController is routed through a Hub-object.

The Hub-object creates an instance of a LocationManager and a Distributor.
The LocationManager manages the location-updates of the iPhone and calculates the so-called DeltaPoint. Relative 
changes (delta) in latitude and longitude. After updating it notifies the Hub (delegate).

The Distributor reformats the Deltapoints and adds received DeltaPoint information to gamepoints.
The gamepoints are saved in a newly created property list.

Note:
Various checks are made for the location updates, i.e. is the event recent (not cached), is the GPS precision high enough.
The app is meant for walking or running purposes, so a check is made to ensure the speed of the iPhone does not exceed
a certain limit.

The MainViewController only displays the current Gamepoints. There is also a navigation controller and bar which
contains a toggle button with which the GPS-location can be turned on and off.
