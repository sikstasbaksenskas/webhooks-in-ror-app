# Webhooks in RoR applications

Secure webhook implementation for third parties to be able to send requests to your application. 

## Example explained

Let's say you are tracking some kind of device's location. That device sends it's location to your system every few minutes.
This example shows a simple way on how to handle that incoming request securely.

- Basic auth.
- Handling incoming params, so later it could processed.
- Simple test coverage.

## Simplified version
```bash
/app/controllers/webhooks/locations_webhook_controller.rb
```

<div align="center">
  <img src="https://raw.githubusercontent.com/sikstasbaksenskas/webhooks-in-ror-app/main/image-1.png" >
</div>

```bash
/app/controllers/concerns/http_auth_concern.rb
```

<div align="center">
  <img src="https://raw.githubusercontent.com/sikstasbaksenskas/webhooks-in-ror-app/main/image.png" >
</div>

## Notes
- Basic auth credentials should be stored in `rails credentials` test `env`(for tests to run).
- `CreateLocation` service is just a placeholder for mocking.
- `Location` migration and model is not needed for this example.

## Improvements

When dealing with this specific functionality in production, some improvements could be done.

- If more requests are coming, renaming of the `webhook` method would make sense.
- You might want to use different auth method - `JWT` for example.
- Test coverage could be improved(error handling, business logic if implemented).