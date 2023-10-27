## Purchase App Backend

This is the backend for the Purchase Application.

## Environment Setup

1. Install necessary packages:  
   `composer install`
   
2. Migrate the database:  
   `php artisan migrate`

3. Import the `purchase_mock_db`.

## Run the Application

Use the following command to start the server:  
`php artisan serve`

## APIs

- `'api/users/update'`: Update a user's information when they complete a purchase.
- `'api/product/get'`: Retrieve all available products.
- `'api/product/checkout'`: Initiate a connection to Stripe when a user makes a purchase.
- `'api/product/getPurchases'`: Fetch purchase details for a specific user.
- `'api/admin/getUserList'`: Retrieve a list of all users for administrative purposes.
- `'api/admin/accessCancel'`: Revoke access for a specific user.
