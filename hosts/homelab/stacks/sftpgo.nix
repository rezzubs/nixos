# Manual steps:
# - Created /mnt/data/sftpgo with bind-mount subdirectories. Used `chmod -R
#   1000:1000` to make it accessible by the container's internal user account.
# - Used the default SQLite data provider. Other providers require calling
#   `sftpgo initprovider` but for SQLite it handles everything automactically.
{
  virtualisation.oci-containers.containers.sftpgo = {
    image = "drakkan/sftpgo:v2.7-alpine";

    ports = [
      "127.0.0.1:20000:8080" # HTTPD: web admin, web client, REST API
      "127.0.0.1:20001:9090" # WebDAV
    ];

    environment = {
      SFTPGO_WEBDAVD__BINDINGS__0__PORT = "9090";
      SFTPGO_WEBDAVD__BINDINGS__0__ENABLE_HTTPS = "false";
      SFTPGO_WEBDAVD__BINDINGS__0__PREFIX = "/dav";
      SFTPGO_WEBDAVD__BINDINGS__0__CLIENT_IP_PROXY_HEADER = "X-Forwarded-For";
      # Docker default subnet range
      SFTPGO_WEBDAVD__BINDINGS__0__PROXY_ALLOWED = "172.16.0.0/12";
    };

    volumes = [
      # Stores persistent data. Will contain WebDAV users.
      "/mnt/data/sftpgo/data:/srv/sftpgo/data"
      # Stores backups
      "/mnt/data/sftpgo/backups:/srv/sftpgo/backups"
      # Home of the sftpgo system user.
      "/mnt/data/sftpgo/home:/var/lib/sftpgo"
    ];
  };
}
