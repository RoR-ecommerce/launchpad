Launchpad
=========

Launchpad is centralized user management system. It provides single point of
access to user information for all UFC resources and single sign-on
functionality for users.

Users act as resource owners with implicit grant of access to UFC resources.

UFC resources (aka clients) implement [OAuth2](http://tools.ietf.org/html/rfc6749)
strategy to let users use the same account across all trusted UFC resources,
thus clients do not need to implement any sign-up, sign-in, reset password, and
main account management functionality.

Instead, all clients redirect users to Launchpad in order to authorize against
users database and automatically grant access to client requesting
authorization. Users credentials are transferred only within Launchpad and
never between user and client.


Client
======

Client (aka resource, aka app) registration in Launchpad system can be done
only by system administrators.

When client is registered, it will receive `client_id` and `client_secret` keys
in order to access the system.

__`client_secret` must never be sent in the clear.__ It designed to be used
only in server-to-server communication. __Server-to-server communication will
only be available over HTTPS (SSL).__

OmniAuth Integration
====================

Clients using Ruby will be receive [OmniAuth](http://www.omniauth.org) strategy
as a gem for seamless integration. Please check
[OmniAuth](https://github.com/RoR-ecommerce/ufc-omniauth) website and
[omniauth-ufc](https://github.com/RoR-ecommerce/ufc-omniauth) gem for
documentation.

OAuth2 Web Application Flow
===========================

Clients using different laguanges will have to implement
[OAuth2](http://tools.ietf.org/html/rfc6749) clients by themselves.

Redirect users to Launchpad
---------------------------

User, in order to register and/or authorize, should be sent to Launchpad
authorization system

```
GET https://launchpad.ufcfit.com/oauth/auth
```

__Parameters__

* _Required_ `client_id` is unique identificator of client, every client will
  receive one upon registration in Launchpad system.
* _Optional_ `state` is an unguessable random string. It is used to protect
  from cross-site forgery attacks.
* _Optional_ `redirect_uri` is URL in your application where user will be sent
  after authorization. `redirect_uri` will also be stored in Launchpad system
  upon client registration.

Launchpad redirects back to your site
-------------------------------------

If user successfully registered or signed-in, Launchpad will redirect user back
to your application authorization endpoint.

Request to your application will contain the following information

* `state` issued by client in previous step.
* `response_type=code` to indicate current OAuth2 authorization flow.
* `code` temporary access code to exchange for `access_token`.

__If `state` do not match the one client issued, the request has been created
by third-party and the process must be aborted.__

Please make sure that your application authorization endpoint is using SSL.

Obtaining `access_token`
------------------------

For POST requests, parameters not included in the URL should be encoded as JSON
with Content-Type of 'application/x-www-form-urlencoded'.

Requests for `access_token` should be made by the following URL

```
POST https://launchpad.ufcfit.com/oauth/token
```

__Parameters__

* _Required_ `grant_type=authorization_code` to indicate that the process is
  still following `authorization_code` flow.
* _Required_ `code` received from previous step.
* _Required_ `client_id` given to client after registration in Launchpad
  system.
* _Required_ `client_secret` given to client after registration in Launchpad
  system.

Upon successful client authorization, Launchpad will respond with the following
JSON response

```json
{
  "access_token": "62506be34d574da4a0d158a67253ea99",
  "token_type": "bearer"
}
```

Obtaining User Information
--------------------------

Unpon receiving `access_token` you are ready to obtain user information and
other information that belongs to user on user behalf.

Request for user information should be made by the following URL

```
GET https://launchpad.ufcfit.com/oauth/user
```

__Parameters__

* _Required_ `access_token` received in previous step.

__`access_token` as well as `client_secret` should never be sent in the
clear__, it is designed only for server-to-server communication.

Launchpad will respond with the following JSON response

```json
{
  "uid": "a5ad3837-805b-497e-91bd-8737fa0e6bd2",
  "first_name": "Moses",
  "last_name": "Song",
  "email": "example@example.com",
  "created_at": "Wed, 03 Apr 2013 23:14:51 PDT -07:00",
  "updated_at": "Wed, 03 Apr 2013 23:14:51 PDT -07:00",
  "country": {
    "alpha3": "USA"
  }
}
```

User information might contain more information as the system being developed.
Please check back to this document for updates.

Errors
======

Launchpad may issue various error responses depending on situation.

1. Request is made with incorrect HTTP verb or given URL does not exist

```
HTTP/1.1 404 Not Found
Content-Type: text/html; charset=utf-8
Content-Length: 773
```

2. Internal error on Launchpad side

```
HTTP/1.1 500 Internal Server Error
Content-Type: text/html; charset=utf-8
Content-Length: 14702
```

Please notify Launchpad administrators in case of such errors.

3. Malformed JSON

```
HTTP/1.1 400 Bad Request
Content-Type: application/json; charset=utf-8
Content-Length: 32

{ "message":"Error parsing JSON" }
```

4. Client cannot be authorized

```
HTTP/1.1 401 Unauthorized
Content-Type: application/json; charset=utf-8
Content-Length: 34

{ "message":"Unauthorized Request" }
```

Please check back to this documentation for updates.
