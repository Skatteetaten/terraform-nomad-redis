job "redis" {
  datacenters = ["dc1"]
  type        = "service"

  group "redis" {
    count = "1"
    network {
      mode = "bridge"
    }

    service {
      name = "redis"
      port = 6379

      check {
        type     = "script"
        name     = "Redis alive"
        task     = "redis-service"
        command  = "redis-cli"
        args     = ["ping"]
        interval = "5s"
        timeout  = "5s"
      }

      connect {
        sidecar_service {}
      }
    }

    task "redis-service" {
      driver = "docker"
      config {
        image = "redis:3-alpine"
      }
    }
  }
}
