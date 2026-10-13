{
  virtualisation.oci-containers.containers.actual-budget = {
    image = "docker.io/actualbudget/actual-server:latest";

    ports = [
      "127.0.0.1:20010:5006"
    ];

    volumes = [
      # '/data' is the path Actual will look for its files in by default, so leave that as-is.
      "/mnt/data/actual-budget:/data"
    ];

    extraOptions = [
      "--health-cmd=node scripts/health-check.js"
      "--health-interval=60s"
      "--health-timeout=10s"
      "--health-retries=3"
      "--health-start-period=20s"
    ];
  };
}
