function ies
    echo (string join " " $argv[3]) | docker exec -i $argv[1] /usr/bin/odoo shell -d $argv[2] --no-http --db_host db --db_port 5432 --db_user odoo --db_password odoo
end
