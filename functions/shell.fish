
function shell
    docker exec -it $argv[1] /usr/bin/odoo shell -d $argv[2] --no-http --db_host db --db_port 5432 --db_user odoo --db_password odoo
end
