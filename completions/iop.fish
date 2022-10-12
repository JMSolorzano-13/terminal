complete -c iop -fr -a "(docker ps --format '{{.Names}}' | grep -v _db)"
