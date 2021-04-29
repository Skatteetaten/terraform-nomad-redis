locals {
  datacenters = join(",", var.nomad_datacenters)
}

data "template_file" "nomad_job_redis" {
  template = file("${path.module}/nomad/redis.hcl")
  vars = {
    datacenters  = local.datacenters
    namespace    = var.nomad_namespace
    image        = var.container_image
    service_name = var.service_name
    host         = var.host
    port         = var.port
    cpu          = var.resource.cpu
    memory       = var.resource.memory
    cpu_proxy    = var.resource_proxy.cpu
    memory_proxy = var.resource_proxy.memory
    use_canary   = var.use_canary
  }
}

resource "nomad_job" "nomad_job_redis" {
  jobspec = data.template_file.nomad_job_redis.rendered
  detach  = false
}