function psql
    docker exec -it $argv[1] psql -U odoo -d $argv[2]
end
