# Perchwell Engineering Take-Home

This is the base repository for the SWE full-stack technical assessment take-home for candidates applying to Perchwell.

# Background Information

Thank you for your interest in Perchwell and for taking the time to complete this technical assessment. Our tech stack consists of React, Coffeescript, and Ruby on Rails.

We estimate you will need approximately 3 hours to complete the following exercise.

# The Deliverable

Please fork or clone this repository to your personal GitHub account. If the repository is public, send it back to us. If it is private, we will send you a list of GitHub handles needing access to your work.

The main framework will be Rails and SQL.

We will review the clarity of your documentation, the correctness of the application, the readability of the code, and the organization within your codebase.

# The Setup

This repository was setup using the latest Ruby on Rails via:

```
rails new engineering_take_home -d postgresql  -j=esbuild -T
```

Once you've downloaded the project the easiest way to run it is with Docker. After installing docker locally:

```
docker compose build
docker compose up
```

If everything works correctly, then you should be able to hit http://localhost:3000/ and see a welcome page with a simple React component.

If you want to run specs, you can run Rspec with from within the Docker container:

```
RAILS_ENV=test bundle exec rspec
```

# The Ask

Create a Rails app with the following components:
* SQL database
* Backend logic
* External APIs

# Background

We are building a platform that stores a list of physical buildings. Stakeholders will interact with our application via API.  We will have two types of stakeholders:
* Clients that submit and create / edit buildings that they own
* External clients that read all buildings from an API

Additionally, clients can request to add custom fields for their associated buildings, adding upon the base attributes for buildings. For example, one client may want their buildings to have a field recording the building color, while another may want to record the building's former use (church, school, etc).

We do not need to build a UI for the clients to modify their custom fields; for this exercise, creating the custom fields for clients' buildings in the database is sufficient.

# SQL Database

Your database schema should support the following main objects, **at a minimum**:

## Clients

Clients are the main application object. Buildings submitted through the API are associated with an existing client.

* Has a name
* Associated with buildings and custom fields

## Buildings

Buildings represent physical buildings

* Has basic address info: Address / State / Zip, etc
* Associated with a client

Additional building attributes specified by the building's client's custom fields should be recorded.

## Custom Fields

Custom Fields represent custom attributes a client wishes to add to the building model. These custom attributes are not shared between clients.

* Custom Fields can be one of 3 types: number, freeform, or enum
  * Number fields can be any decimal number (e.g., Number of bathrooms: 2.5)
  * Freeform fields are strings (e.g., Living room color: “Blue”)
  * Enum is a choice of strings (e.g., Type of walkway: “Brick, Concrete, or None”)
* Custom Fields are associated with a single client

## Seed Data

* Seed the clients table with 5 clients. You can name the clients anything you wish.
* Seed a small sample of custom fields for each client.
* Seed a small sample of buildings for each client that contain values for the custom fields.

## Indexes

Please create indexes that make sense for the application.

# External APIs:

Note: We do NOT need to worry about Authentication for this exercise. Consider all the APIs to be ‘open’ for now.

Create the following API Endpoints to facilitate the following actions:

From a client:

## Create Building
* Create a single Building associated with a client
* Save the values for Custom Fields for buildings associated with the client
* Return an error and do not save if any values were sent that were incorrect.
  * Example: Send a string as a number field or a key that doesn't work with the custom fields
  * Return a success message if it is saved correctly

## Edit Building
* Same constraints as creating, but editing an existing building by targeting its primary id

## Read Buildings
* Returns all the buildings, for all clients
* Must support basic pagination functionality
* Returns the address information associated with each building
* Returns the client's name
* Returns the custom field values associated with each building, even if they are blank

Simplified read building output:

```
{
  "status": "success",
  "buildings": [
    {
      "id": "1",
      "client_name": "rock_walls_only",
      "address": "45 Main St",
      "rock_wall_size": "15",
      "rock_wall_length": "26"
    },
    {
      "id": "2",
      "client_name": "brick_walls_only",
      "address": "123 Side St",
      "brick_color": "red",
      "brick_count": ""
    }
  ]
}
```

# React Frontend
The frontend portion of this project is located here: `/app/javascript/components`

* Write an API call to fetch all building data and display each building in a card component written in React.
* Create an interface using React components to create a new building and edit an existing building, complete with the necessary API calls.
* Proper functionality should be the main focus here. Any styling choices are bonus points but it should be readable so add margin and padding for spacing as needed.
* This should demonstrate a competent use of React hooks to manage state.
