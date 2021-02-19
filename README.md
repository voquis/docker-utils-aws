AWS Utilities Image
===
This image provides the following tools for managing AWS infrastructure:
- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) to communicate directly with AWS APIs
- [Terraform](https://www.terraform.io) to manage AWS infrastructure as code, note this is installed via [tfenv](https://github.com/tfutils/tfenv).
- [aws-profile](https://pypi.org/project/aws-profile/) for managing and assuming AWS roles
- [aws-vault](https://github.com/99designs/aws-vault) for managing and assuming AWS roles

# Usage
## Basic example
Start the container with no volume mounts.
```shell
docker run -i -t voquis/utils-aws bash
```

## Complete example
To run with an existing Terraform project and AWS profiles set up on disk (in `~/.aws`) and ssh configuration (in `~/.ssh`) available to the container:
```shell
docker run -it \
--name my-tf-project \
-v /path/to/my/tf/project:/project \
-v $HOME/.ssh:/root/.ssh \
-v $HOME/.aws:/root/.aws \
-w /project \
voquis/utils-aws \
bash
```

To run a command with `aws-profile` for a particular AWS role, for example:
```shell
aws-profile -p <PROFILE NAME> terraform init
```

To install a different version of terraform and switch to it:
```shell
tfenv install <version number>
```

To lock a project to a specific version of terraform, add a `.terraform-version` file to the root of the Terraform project with a single line for the desired version number.

# Building and running locally
First clone this repository with:
```shell
git clone https://github.com/voquis/docker-utils-aws.git
```
Then change to cloned directory (`cd docker-utils-aws`) and build the image with:
```
docker build -t voquis/utils-aws/local .
```

Run the local image with:
```shell
docker run -i -t voquis/utils-aws/local bash
```
