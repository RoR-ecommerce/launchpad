Launchpad
=========

Launchpad is centralized user management system. It provides single point of
access to user information for all UFC resources and single sing-on
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

1. User, in order to register and/or authorize, should be sent to Launchpad
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

Obtaining `access_token`
------------------------

All further communication to Launchpad will be available only available
throught JSON requests, which means every request must contain the following
headers

```
Content-Type: application/json
Accept: application/json
```

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

```
{ "access_token":"62506be34d574da4a0d158a67253ea99","token_type":"bearer" }
```

Obtaining User Information
--------------------------

Unpon receiving `access_token` you are ready to obtain user information and
other information that belongs to user on user behalf.
