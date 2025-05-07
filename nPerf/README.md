USER="nperf-server"
DAEMON="/usr/bin/nPerfServer"
PID="/var/lib/nperf-server/nPerfServer.pid"
UUID="/var/lib/nperf-server/nPerfServer.uuid"



nPerf server Linux v2.2.8 2024-08-26
Allowed options:

Generic options:
  -h [ --help ]                 produce help message
  -v [ --version ]              show version
  -d [ --debug ]                show debug messages
  -a [ --accesslog ]            show connection messages
  -x [ --daemon ]               run as a daemon
  -c [ --hionly ]               handle CONNECT requests only
  --pidfile arg                 set pidfile to use for daemon mode
  --basedir arg                 set base dir for cert, key & uuid files
  --certfile arg                set certificate file for TLS
  --keyfile arg                 set key file for TLS
  --uuidfile arg                set UUID file
  --disable-close-wait-checks   Disable TCP Close-Wait checks
  -l [ --lan ]                  LAN mode, reports LAN IP to server.
  --lanif arg                   LAN mode, force consider given interface as 
                                default interface

Tuning:
  -w [ --workers ] arg          set numbers of workers (threads) to use, NB: 
                                one thread can serve multiple clients !
  -i [ --ip ] arg               set hostnames/IPs to listen on
  -p [ --port ] arg             set TCP port to listen on
  -t [ --tlsport ] arg          set TCP port to listen on for TLS connections
  -b [ --buffer ] arg           set size of random buffer for download data
  -r [ --rcs ] arg              set receive chunk size for upload test
  -s [ --scs ] arg              set send chunk size for download test
  --rbs arg                     set socket's receive buffer size
  --sbs arg                     set socket's send buffer size



USER="nperf-server"
DAEMON="/usr/bin/nPerfServer"
PID="/var/lib/nperf-server/nPerfServer.pid"
UUID="/var/lib/nperf-server/nPerfServer.uuid"





/usr/bin/nPerfServer --uuidfile /var/lib/nperf-server/nPerfServer.uuid --basedir /etc/nperf/nperf-server.conf --pidfile /var/lib/nperf-server/nPerfServer.pid -p 80 -t 443 -i :: -x