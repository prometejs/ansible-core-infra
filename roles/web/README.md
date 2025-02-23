Sites Variable Fields

```
- name: prometejs
    enable: true
    protocol: http # stream(tcp/udp) or mail(IMAP, POP3 or SMTP)
    config:
      upstreams:
        - name:
          load_balancing_method:
          zone:
          hash: 
          servers:
            - address: 
              parameters:
      servers:
        - name:
          port:
          ssl: 
            ssl_certificate:
            ssl_certificate_key:
          keepalive_timeout: 
          access_log:
          error_log:

          redirect:
            protocol: https
            code: 301 

          locations:
            - path:
              pattern:
              root:
              index:
              try_files:
              expires:
              access_log:
              error_log:
              headers:
                proxy: []
                static: []
```

Static Site Example
Variable
```
site:
    servers:
      - name: prometejs.io
        port: 443
        ssl: 
          ssl_certificate: cert.crt
          ssl_certificate_key: cert.pem
        locations: 
          - path: /
            root: app_prometejs_root
          - path: ~*
            pattern: \.(js|jpg|png|css|txt)$
            root: app_prometejs_root
            headers:
              static:
                - Cache-Control "public"

      - name: prometejs.io
        port: 80
        redirect:
          protocol: https
```
Config
```
# Prometejs Static Site server
server {
    listen              443 ssl;
    listen              [::]:443 ssl;
    server_name         prometejs.ddns.net;
    keepalive_timeout   60s;

    access_log          /var/log/prometejs.ddns.access.log;
    error_log           /var/log/prometejs.ddns.error.log;

    ssl_certificate     /etc/ssl/sites/certs/prometejs.pem;
    ssl_certificate_key /etc/ssl/sites/private/prometejs.key;

    location / {
        root    /var/www/prometejs.ddns.net/;
        index   index.htm index.html;
        try_files $uri $uri/ =404;
    }

    location ~* \.(js|jpg|png|css|txt)$ {
        root /var/www/prometejs.ddns.net/;
        expires 1y; # Cache static files for 1 year
        access_log off; # Turn off logging for performance
        add_header Cache-Control "public";
    }
}

# Redirect http to https
server {
    listen      80;
    listen      [::]:80;
    server_name prometejs.ddns.net;
    return 301  https://prometejs.ddns.net$request_uri;
    keepalive_timeout           60s;
    access_log                  /var/log/prometejs.io.access.log;
    error_log                   /var/log/prometejs.io.error.log;
}
```


Template Testing Site
https://ansible.sivel.net/test/


Variables 
```
site:
    servers:
      - name: prometejs.io
        port: 443
        ssl: 
          ssl_certificate: cert.crt
          ssl_certificate_key: cert.pem
        locations: 
          - path: /
            root: app_prometejs_root
          - path: ~*
            pattern: \.(js|jpg|png|css|txt)$
            root: app_prometejs_root
            headers:
              static:
                - Cache-Control "public"

      - name: prometejs.io
        port: 80
        redirect:
          protocol: https
```
Rendered
```
server {

    listen                      443 ssl;
    listen                      [::]:443 ssl;
    server_name                 prometejs.io;
    keepalive_timeout           60s;

    access_log                  /var/log/prometejs.io.access.log;
    error_log                   /var/log/prometejs.io.error.log;

    # SSL configuration
    ssl_certificate             cert.crt;
    ssl_certificate_key         cert.pem;
    ssl_prefer_server_ciphers   on;



 
    location /  {
        root                    app_prometejs_root;
        access_log              off; # Turn off logging for performance
        error_log               on;
    }
 
    location ~*  \.(js|jpg|png|css|txt)$  {
        root                    app_prometejs_root;
        access_log              off; # Turn off logging for performance
        error_log               on;
 
        add_header              Cache-Control "public"
    }

}
server {

    listen                      80 ;
    listen                      [::]:80 ;
    server_name                 prometejs.io;
    keepalive_timeout           60s;

    access_log                  /var/log/prometejs.io.access.log;
    error_log                   /var/log/prometejs.io.error.log;


    # Redirect configuration
    return  301  https://$host$request_uri;



}

```