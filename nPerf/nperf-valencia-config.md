


    ipv4:     190.89.30.142/30
    Gateway:  190.89.30.141
    mascara:  255.255.255.252
    red:      190.89.30.140/30

RED: 2803:C000:13E:1::6C/126
GATEWAY: 2803:C000:13E:1::6D
IPV6 UTILIZAR: 2803:C000:13E:1::6E/126



DualStack
```
docker network create -d macvlan \
    --subnet=190.89.30.140/30 \
    --gateway=190.89.30.141 \
    --ipv6 --subnet=2803:C000:13E:1::6C/126 --gateway=2803:C000:13E:1::6D \
     -o parent=ens3f0 \
     -o macvlan_mode=bridge nperf
```


Ejeucion con la red dualstack
---

docker run --rm -dit \
        --network nperf \
        --name nperf \
        --cpus="8" \
        --memory "8g" \
        -h nperf-valencia \
        debian:nperf \
        bash



docker run --rm -dit \
        --network nperf \
        --name nperf \
        --cpus="8" \
        --memory "8g" \
        -h nperf-valencia \
        debian:nperf \
