function dupd
    docker exec -it $argv[1] odoo --http-port 8070 --db_host db --db_port 5432 --db_user odoo --db_password odoo -d $argv[2] -u $argv[3] --stop-after-init
end
