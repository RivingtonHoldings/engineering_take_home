# Perchwell Engineering Take-Home

Welcome to the Perchwell take-home assignment!

# Requirements

Please see the requirements [here](https://github.com/RivingtonHoldings/engineering_take_home/blob/main/REQUIREMENTS.md).

# Curl Tests

buildings#index
```
curl localhost:3000/buildings
```
buildings#show
```
curl localhost:3000/buildings/1
```
buildings#create
```
curl -d '{"client_id":1, "street_address_one":"200 Greene St", "city": "Jersey City", "state": "NJ", "zipcode": "07311"}' -H "Content-Type: application/json" -X POST http://localhost:3000/buildings
```

buildings#update
```
curl -d '{"client_id":1, "street_address_one":"200 Greene St", "city": "Jersey City", "state": "NJ", "zipcode": "07311"}' -H "Content-Type: application/json" -X PUT http://localhost:3000/buildings/1
```

