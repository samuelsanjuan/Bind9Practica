$TTL    3600
@       IN      SOA     ns.danielcastelao.com. ssanjuanandres.danielcastelao.org. (
                   2022051001           ; Serial
                         3600           ; Refresh [1h]
                          600           ; Retry   [10m]
                        86400           ; Expire  [1d]
                          600 )         ; Negative Cache TTL [1h]
;
@       IN      NS      ns.danielcastelao.com.
@       IN      MX      10 ssanjuanandres.danielcastelao.org.

ns      IN      A       10.1.0.101
etch    IN      A       10.1.0.5


pop     IN      CNAME   ns
www     IN      CNAME   etch
mail    IN      CNAME   etch
