# tools

Collection of useful scripts

## Docker

All tools are build within alpine image

### Docker image build

```bash
./build.sh
```

### Docker image run

```bash
./run.sh <command>
```

with the following commands available:

```
packer <ver 1.3.5>
drone client <ver 1.0.7>
aws-cli <latest ver>
terraform <ver 0.11.10>
python <latest 3.x version>
    - s3cmd>=2.0.2
    - python-magic>=0.4.15
    - botocore>=1.12.127
    - boto3>=1.9.127
    - numpy>=1.16.2
    - pandas>=0.24.2
```

It will transfer the following Environment Variables to docker runtime:

```sh
    - AWS_ACCESS_KEY_ID
    - AWS_DEFAULT_REGION
    - AWS_REGION
    - AWS_SECRET_ACCESS_KEY
    - AWS_SECURITY_TOKEN
    - AWS_SESSION_TOKEN
    - AWS_VAULT
    - AWS_VAULT_BACKEND
```

If you require all environment variables to be transferred please uses:

```bash
./run_all_env.sh <command>
```

However this may have undesired consequences, depending on your environment

### `git_push.sh`

Pushes any changes in this directory to git.
If you want to have it automatically updated every hour by this script add this line 
to your crontab (by running `crontab -e`)

```bash
* * * * * /<path>/<to>/git_push.sh
```

## Tools in `src`

### bash

Bash configuration, runtime, aliases etc.

### ubuntu

Ubuntu specific scripts

### centos

Centos specific scripts

### docker

Docker specific scripts

### testing

Testing specific scripts

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, 
and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
