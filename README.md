# Setup

## Hostnames

Ensure that hostname `rmq0` and `rmq1` resolve to `127.0.0.1`:

```
C:\Users\lbakken\development\lukebakken\erlang-ssl_dist_optfile-utf8 [main ↑1 +1 ~3 -0 | +0 ~4 -0 !]
> ping -n 1 rmq0

Pinging prokofiev [127.0.0.1] with 32 bytes of data:
Reply from 127.0.0.1: bytes=32 time<1ms TTL=128

C:\Users\lbakken\development\lukebakken\erlang-ssl_dist_optfile-utf8 [main ↑1 +1 ~3 -0 | +0 ~4 -0 !]
> ping -n 1 rmq1

Pinging prokofiev [127.0.0.1] with 32 bytes of data:
Reply from 127.0.0.1: bytes=32 time<1ms TTL=128

```

## Run the setup script

In both the POSIX and Windows case, the setup script will generate an
`ssl_dist_optfile.*.conf` file that should be valid, and contains the UTF-8
string Евгений

# Reproduction

## Windows

In a Powershell console:

```
.\setup.ps1
& erl.exe -proto_dist inet_tls -sname n0@rmq0 -ssl_dist_optfile .\ssl_dist_optfile.rmq0.conf
> node().
```

In a second Powershell console:

```
> & erl.exe -proto_dist inet_tls -sname n1@rmq1 -ssl_dist_optfile .\ssl_dist_optfile.rmq1.conf
net_kernel:verbose(2).
net_adm:ping('n0@rmq0').
```

### Output

* Node `n1@rmq1`:

```
> & erl.exe -proto_dist inet_tls -sname n1@rmq1 -ssl_dist_optfile .\ssl_dist_optfile.rmq1.conf
Erlang/OTP 26 [erts-14.2.3] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Eshell V14.2.3 (press Ctrl+G to abort, type help(). for help)
(n1@rmq1)1> net_kernel:verbose(2).
0

(n1@rmq1)2> net_adm:ping('n0@rmq0').
=INFO REPORT==== 21-Mar-2024::09:51:44.931000 ===
{net_kernel,{auto_connect,n0@rmq0,
                          {9353549,#Ref<0.1760061022.3584950279.199020>}}}
=INFO REPORT==== 21-Mar-2024::09:51:44.943000 ===
{net_kernel,{setup,n0@rmq0,normal,n1@rmq1,shortnames,<0.111.0>}}
=INFO REPORT==== 21-Mar-2024::09:51:45.012000 ===
{net_kernel,
    {conn_own_exit,<0.111.0>,
        {ssl_connect_failed,
            {127,0,0,1},
            61993,
            {error,
                {options,
                    {cacertfile,
                        [99,58,47,85,115,101,114,115,47,108,98,97,107,107,101,
                         110,47,100,101,118,101,108,111,112,109,101,110,116,
                         47,108,117,107,101,98,97,107,107,101,110,47,101,114,
                         108,97,110,103,45,115,115,108,95,100,105,115,116,95,
                         111,112,116,102,105,108,101,45,117,116,102,56,47,99,
                         101,114,116,115,32,195,144,194,149,195,144,194,178,
                         195,144,194,179,195,144,194,181,195,144,194,189,195,
                         144,194,184,195,144,194,185,47,99,97,95,99,101,114,
                         116,105,102,105,99,97,116,101,46,112,101,109],
                        {error,enoent}}}}},
        n0@rmq0}}
pang
=INFO REPORT==== 21-Mar-2024::09:51:45.012000 ===
{net_kernel,{net_kernel,1441,nodedown,n0@rmq0}}
=INFO REPORT==== 21-Mar-2024::09:51:45.012000 ===
{net_kernel,{disconnect,n0@rmq0}}
(n1@rmq1)3>
```

* Node `n0@rmq0`:

```
> & erl.exe -proto_dist inet_tls -sname n0@rmq0 -ssl_dist_optfile .\ssl_dist_optfile.rmq0.conf
Erlang/OTP 26 [erts-14.2.3] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Eshell V14.2.3 (press Ctrl+G to abort, type help(). for help)
=ERROR REPORT==== 21-Mar-2024::09:51:45.073000 ===
Cannot accept TLS distribution connection: Invalid CA certificate file c:/Users/lbakken/development/lukebakken/erlang-ssl_dist_optfile-utf8/certs ÃÂÃÂ²ÃÂ³ÃÂµÃÂ½ÃÂ¸ÃÂ¹/ca_certificate.pem: no such file or directory

(n0@rmq0)1>
```

## POSIX

In a `bash` shell:

```
./setup.sh
erl -proto_dist inet_tls  -sname 'n0@rmq0' -ssl_dist_optfile ./ssl_dist_optfile.rmq0.conf
> node().
```

In a second `bash` shell:

```
erl -proto_dist inet_tls -sname 'n1@rmq1' -ssl_dist_optfile ./ssl_dist_optfile.rmq1.conf
> net_kernel:verbose(2).
> net_adm:ping('n0@rmq0').
```

### Output

Output is similar to the Windows case.
