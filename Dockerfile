# Use a base image (Debian or Ubuntu)
FROM ubuntu:20.04

# Set environment variable to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the base image and install utilities
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    unzip \
    sudo \
    lsb-release \
    software-properties-common \
    ca-certificates \
    gnupg2 \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

# Install Python and pip
RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (with npm)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Java (OpenJDK)
RUN apt-get update -y && apt-get install -y \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://go.dev/dl/go1.18.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xvzf go1.18.3.linux-amd64.tar.gz \
    && rm go1.18.3.linux-amd64.tar.gz

# Install Ruby
RUN apt-get update -y && apt-get install -y \
    ruby-full \
    && rm -rf /var/lib/apt/lists/*

# Install PHP
RUN apt-get update -y && apt-get install -y \
    php \
    php-cli \
    php-mbstring \
    php-xml \
    php-curl \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install C/C++ (GCC)
RUN apt-get update -y && apt-get install -y \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Install Swift
RUN apt-get update -y && apt-get install -y \
    clang \
    libicu-dev \
    libssl-dev \
    && wget https://swift.org/builds/swift-5.6.1-release/ubuntu2004/swift-5.6.1-RELEASE/swift-5.6.1-RELEASE-ubuntu20.04.tar.gz \
    && tar xzf swift-5.6.1-RELEASE-ubuntu20.04.tar.gz \
    && mv swift-5.6.1-RELEASE-ubuntu20.04 /usr/local/swift \
    && rm swift-5.6.1-RELEASE-ubuntu20.04.tar.gz

# Install TypeScript globally
RUN npm install -g typescript

# Install .NET SDK
RUN wget https://download.visualstudio.microsoft.com/download/pr/c0e5e836-d9f0-45ac-8b2d-dab9b5d74e60/0367105e7c7bdf7e99d413c4f4a2be9f/dotnet-sdk-6.0.100-linux-x64.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar zxf dotnet-sdk-6.0.100-linux-x64.tar.gz -C /usr/share/dotnet \
    && rm dotnet-sdk-6.0.100-linux-x64.tar.gz

# Set environment variables for Go and Swift
ENV PATH=$PATH:/usr/local/go/bin:/usr/local/swift/usr/bin:/usr/share/dotnet

# Cleanup
RUN apt-get autoremove -y && apt-get clean

# Verify the installations
RUN python3 --version && \
    node --version && \
    npm --version && \
    java -version && \
    go version && \
    ruby --version && \
    php --version && \
    rustc --version && \
    gcc --version && \
    swift --version && \
    tsc --version && \
    dotnet --version

# Set the working directory
WORKDIR /workspace

# Command to run when the container starts (default shell)
CMD ["bash"]
