output "redis_service" {
  description = "Redis service name"
  value       = data.template_file.nomad_job_redis.vars.service_name
}

output "redis_port" {
  description = "Redis port number"
  value       = data.template_file.nomad_job_redis.vars.port
}

output "redis_host" {
  description = "Redis host"
  value       = data.template_file.nomad_job_redis.vars.host
}