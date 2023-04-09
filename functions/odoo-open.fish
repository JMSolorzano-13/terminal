function odoo-open
	open (docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $argv[1]_web_1):8070
end
