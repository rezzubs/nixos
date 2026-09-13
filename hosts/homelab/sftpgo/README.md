# Setup

- Created /mnt/data/sftpgo with bind-mount subdirectories. Used `chmod -R 1000:1000` to make it accessible by the container's internal user account.
- Used the default SQLite data provider (doesn't require configuration).
  - Other providers require calling `sftpgo initprovider` but for SQLite it does everything automactically.
