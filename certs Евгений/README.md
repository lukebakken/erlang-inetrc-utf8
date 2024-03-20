# Verification

Use the following commands to verify the certs in this directory

## Server

```
openssl s_server -CAfile ./ca_certificate.pem -cert ./server_rmq0_certificate.pem -key ./server_rmq0_key.pem -verify 1
```

## Client

```
openssl s_client -connect rmq0:4433 -CAfile ./ca_certificate.pem -cert ./client_rmq0_certificate.pem -key ./client_rmq0_key.pem
```
