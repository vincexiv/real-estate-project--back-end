# Ruby API for a real-estate app

## Brief Description
This api provides endpoints through which data regarding house for sell can be obtained. It also offers some crud operations such as posting new data about houses, editing existing data, or even deleting. More on this will be provided in the description section

## Date of Current Version
November 9, 2022

## Done by
[vincent Makokha](https://github.com/VinceXIV/)
[Andrew Ochieng](https://github.com/Andrew-Ochieng)
[Mercy Cheruiyot](https://github.com/Mercy-Cheruiyot)
[Rajab Karume](https://github.com/RajabKarume)
[Zablon Onchari Nyabuto](https://github.com/Zablon-Onchari-Nyabuto)

## Description
These are the things that you will be able to do using this api, and how you can get it working

### GET
There are six endpoints for the get request as at now;
#### 1. _/houses/:id_
Using this endpoint, the details about a house in the following format;
```
{
    "id": 1,
    "location_id": 4,
    "category_id": 3,
    "location": "kisumu",
    "category": "3 bedroom",
    "price": 49838.0,
    "description": "Aspernatur voluptatem aut. Id omnis quia.",
    "size_in_sqft": 6064,
    "image": "https://images.pexels.com/photos/3935333/pexels-photo-3935333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
}
```
#### 2. _/houses_
Using this endpoint, a list of houses, each of the house details being similar in form with what you get with _houses/:id_ above

#### 3. _/categories/:id_
Use this if you only want houses belonging to a certain category

#### 4. _/categories
You can also get all houses, but in this case, grouped by categories they belong

#### 5. _/locations/:id_
If you want to get houses from certain location, use this end point

#### 6. _/locations
Like the _/categories_ endpoint, you can also get all houses in the database organized by locations

### POST
There's only one end point for this so far, and that is the **/houses**. Even though you get information such as the *location_id* and *category_id* when you do a get request on this end point, you are note required to input these on a post request. The database will get new or existing ids of the locations depending on whether such locations are already in the database or not. As such, the object in the post request should be in the following format;
```{
    "id": 1,
    "location": "kisumu",
    "category": "3 bedroom",
    "price": 49838.0,
    "description": "Aspernatur voluptatem aut. Id omnis quia.",
    "size_in_sqft": 6064,
    "image": "https://images.pexels.com/photos/3935333/pexels-photo-3935333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
}
```

### PATCH
Like post request, there's only one endpoint created for editing exising data as at now, and that is the **/houses/:id**. Unlike post request, you can specify one or more items that you want changed in that item. For instance, the body of the patch can simply be;
```{
    "location": "kisumu",
    "category": "3 bedroom"
   }
```
Only the items in the body will be changed while the rest will remain as they were in the database

### DELETE
You can delete an entry by using the end point **/house:id** with a delete request. Doing that will destroy the item from the database

## Built With
Ruby

## Prerequisites
You need to have ruby installed. The version being used herein is 2.7.4, so it's preferable that you use that one too. Another thing you will need to do is have bundler (a ruby gem) installed. You will be using it to install the dependencies listedin the Gemfile

## Setup Instructions
1. clone the repo
2. run `bundle install`
3. run `bundle exec rake db:migrate && bundle exec rake db:seed:replant`
4. run `rake server`

At this point, the endpoints will have been created that you can use to access different data, edit them, or delete them from the database

## Support and Contact Details
name: Vincent Makokha
email: makokhavomondi@gmail.com

## License
MIT License

Copyright (c) 2022 JamiiEstate

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
