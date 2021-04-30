<!-- markdownlint-disable MD041 -->
<p align="center"><a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template" alt="Built on"><img src="https://img.shields.io/badge/Built%20from%20template-Vagrant--hashistack--template-blue?style=for-the-badge&logo=github"/></a><p align="center"><a href="https://github.com/fredrikhgrelland/vagrant-hashistack" alt="Built on"><img src="https://img.shields.io/badge/Powered%20by%20-Vagrant--hashistack-orange?style=for-the-badge&logo=vagrant"/></a></p></p>

> :warning: The text under headlines are examples, and should be removed.
>
> :warning: Remove this line and the one above!

# Terraform-nomad-redis
This module is IaC - infrastructure as code which contains a nomad job of [Redis](https://redis.io/).

## Content
1. [Compatibility](#compatibility)
2. [Requirements](#requirements)
    1. [Required modules](#required-modules)
    2. [Required software](#required-software)
3. [Usage](#usage)
    1. [Verifying setup](#verifying-setup)
    2. [Providers](#providers)
4. [Example usage](#example-usage)
5. [Inputs](#inputs)
6. [Outputs](#outputs)
7. [License](#license)

## Compatibility
|Software|OSS Version|Enterprise Version|
|:---|:---|:---|
|Terraform|0.13.1 or newer||
|Consul|1.8.3 or newer|1.8.3 or newer|
|Vault|1.5.2.1 or newer|1.5.2.1 or newer|
|Nomad|0.12.3 or newer|0.12.3 or newer|

## Requirements

### Required modules
| Module | Version |
| :----- | :------ |
| None | - |

### Required software
All software is provided and run with docker. See the [Makefile](Makefile) for inspiration.


## Usage
The following command will run Redis in the [example/standalone](example/standalone) folder.
```sh
make up 
```


### Verifying setup
You can verify the setup by connention to Redis using the Nomad UI at [localhost:4646](http://localhost:4646/).
Follow the steps below:
1. Locate and click the _redis_ nomad-job.
2. Click the _exec_ button and connect to the _redis_ --> _redis-service_-task.
3. Run `redis-cli` to connect to Redis Cli.
4. Run `ping`. Your output should look like this:
```sh
127.0.0.1:6379> ping
PONG
```

### Providers
- [Nomad](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs)
- [Vault](https://registry.terraform.io/providers/hashicorp/vault/latest/docs)


## Example usage
Example-code that shows how to use the module and, if applicable, its different use cases.
```hcl-terraform
module "redis" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"

  # redis
  service_name    = "redis"
  host            = "127.0.0.1"
  port            = 6379
  container_image = "redis:3-alpine"

}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| nomad\_datacenters | Nomad data centers | list(string) | ["dc1"] | yes |
| nomad\_namespace | [Enterprise] Nomad namespace | string | "default" | yes |
| service\_name | Redis service name | string | "redis" | yes |
| host | Redis host | string | "127.0.0.1" | yes |
| port | Redis container port | number | 6379 | yes |
| container\_image | Redis container image | string | "redis:3-alpine" | yes |
| resource | Resource allocations for cpu and memory | obj(number, number)| { <br> cpu = 200, <br> memory = 128 <br> } | no |
| resource_proxy | Resource allocations for proxy | obj(number, number)| { <br> cpu = 200, <br> memory = 128 <br> } | no |
| use\_canary | Uses canary deployment for Redis | bool | false | no |


## Outputs
| Name | Description | Type |
|------|-------------|------|
| redis_service | Redis service name | string |
| redis_port | Redis port number | number |
| redis_host | Redis host | string |


## License
This work is licensed under Apache 2 License. See [LICENSE](./LICENSE) for full details.
