# How Does One Use This?

Please note that the master branch is generally *unstable*.
If you are looking for something"tested", please consume one
of our [releases](https://github.com/pivotal-cf/terraforming-openstack/releases).

## What Does This Do?

You will get a booted ops-manager VM plus some networking - just the bare bones basically.

## Looking to setup a different IAAS

We have have other terraform templates to help you!

- [aws](https://github.com/pivotal-cf/terraforming-aws)
- [azure](https://github.com/pivotal-cf/terraforming-azure)
- [gcp](https://github.com/pivotal-cf/terraforming-gcp)
- [vsphere](https://github.com/pivotal-cf/terraforming-vsphere)

## Prerequisites

You will need `terraform`:

```bash
brew update
brew install terraform
```

### Var File

Copy the stub content below into a file called `terraform.tfvars`
and put it in the root of this project.

These vars will be used when you run `terraform  apply`.

You should fill in the stub values with the correct content.

```hcl
env_name =
```

### Var Details
- env_name: **(required)** An arbitrary unique name for namespacing resources.

## Running

Note: please make sure you have created the `terraform.tfvars` file above as mentioned.

### Standing up environment

```bash
terraform init
terraform plan -out=plan
terraform apply plan
```

### Tearing down environment

```bash
terraform destroy
```
