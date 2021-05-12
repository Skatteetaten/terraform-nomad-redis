locals {
  datacenters = join(",", var.nomad_datacenters)
}

data "template_file" "nomad_job_redis" {
  template = file("${path.module}/nomad/redis.hcl")
  vars = {
    service_name = var.service_name
    cpu_proxy    = var.resource_proxy.cpu
    memory_proxy = var.resource_proxy.memory
    datacenters  = local.datacenters
    consul_tags  = join(",", var.consul_tags)
    namespace    = var.nomad_namespace
    port         = var.port
    image        = var.container_image
    cpu          = var.resource.cpu
    memory       = var.resource.memory
    use_canary   = var.use_canary
  }
}

resource "nomad_job" "nomad_job_redis" {
  jobspec = data.template_file.nomad_job_redis.rendered
  detach  = false
}