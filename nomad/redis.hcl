job "redis" {
  type        = "service"
  datacenters = ["${datacenters}"]
  namespace   = "${namespace}"

  update {
    max_parallel      = 1
    health_check      = "checks"
    min_healthy_time  = "10s"
    healthy_deadline  = "55m"
    progress_deadline = "1h"
%{ if use_canary }
    canary            = 1
    auto_promote      = true
    auto_revert       = true
%{ endif }
    stagger           = "30s"
  }

  group "redis" {
    count = 1
    network {
      mode = "bridge"
    }

    service {
      name = "${service_name}"
      port = "${port}"
      connect {
        sidecar_service {}
        sidecar_task {
        resources {
          cpu     = "${cpu_proxy}"
          memory  = "${memory_proxy}"
          }
        }
      }
      check {
        type     = "script"
        name     = "Redis alive"
        task     = "redis-service"
        command  = "redis-cli"
        args     = ["ping"]
        interval = "5s"
        timeout  = "5s"
      }
    }

    task "redis-service" {
      driver = "docker"
      config {
        image = "${image}"
      }
    }
  }
}
