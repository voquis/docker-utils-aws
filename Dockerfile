FROM python:3.9-slim

# https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst
ARG AWS_CLI_VERSION=2.1.27
# https://github.com/99designs/aws-vault/tags
ARG AWS_VAULT_VERSION=v6.2.0

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
            git \
            curl \
            unzip \
            vim

# Install AWS CLI
RUN curl -L -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip"
RUN unzip awscliv2.zip
RUN bash aws/install
RUN rm awscliv2.zip

# Install AWS Vault
RUN curl -L -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/${AWS_VAULT_VERSION}/aws-vault-linux-amd64
RUN chmod +x /usr/local/bin/aws-vault

# Install AWS Profile
RUN pip install aws-profile

# Install Terraform with version manager (tfenv)
RUN git clone https://github.com/tfutils/tfenv.git /usr/share/tfenv
RUN /usr/share/tfenv/bin/tfenv install
RUN /usr/share/tfenv/bin/tfenv use
RUN echo 'export PATH="/usr/share/tfenv/bin:$PATH"' >> /root/.bashrc

# Install Packer with version manager (pkenv)
RUN git clone https://github.com/iamhsa/pkenv.git /usr/share/pkenv
RUN /usr/share/pkenv/bin/pkenv install $(/usr/share/pkenv/bin/pkenv list-remote | head -n 1)
RUN echo 'export PATH="/usr/share/pkenv/bin:$PATH"' >> /root/.bashrc
