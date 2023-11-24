*** Settings ***
Documentation                Base 

Library                            SeleniumLibrary
Library                            Collections
Library                            RequestsLibrary
Library                            OperatingSystem
Library                            String

Resource                           Variables.robot
Resource                           Authentication.robot
Resource                           Actions/SearchEventsByma.robot
Resource                           Actions/SearchEventsIngresse.robot
Resource                           Actions/SearchEventsSympla.robot


*** Keywords ***

Open The Browser
    Open Browser    browser=gc    
    Maximize Browser Window


Close The Browser
    Close Browser
