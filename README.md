# Docker for zentao

## Run

1. Copy zentaopms folder to /opt/vol/zentaopms

2. Set nginx file as below

    ```nginx
    server {
        listen  80;

        server_name zentao.example.com;
        root /opt/vol/zentaopms;
        set $fastcgi_root /opt/web;

        location / {
            index index.html index.php;
            if (-f $request_filename) {
                break;
            }
            if (!-e $request_filename) {
                rewrite ^(.*)$ /index.php/$1 last;
                break;
            }
        }

        location ~ .+\.php($|/) {
            fastcgi_pass                127.0.0.1:9000;
            fastcgi_split_path_info     ^((?U).+.php)(/?.+)$;
            fastcgi_param PATH_INFO     $fastcgi_path_info;
            fastcgi_param PATH_TRANSLATED    $document_root$fastcgi_path_info;
            fastcgi_param SCRIPT_FILENAME    $fastcgi_root$fastcgi_script_name;
            include                     fastcgi_params;
        }
    }
    ```

3. Run docker with docker-compose

    ```bash
    docker-compose up -d
    ```

    or with only docker

    ```bash
    docker run -d -p 9000:9000 -v /opt/vol/zentaopms:/opt/web playniuniu/zentao-php
    ```
