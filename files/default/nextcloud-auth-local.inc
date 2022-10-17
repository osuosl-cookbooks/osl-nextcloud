# Apache config snippet. To be used by /etc/httpd/conf.d/*.conf files
# with Include. Allows access only from local system.

<IfModule mod_authz_core.c>
# Apache 2.4
Require local
</IfModule>
