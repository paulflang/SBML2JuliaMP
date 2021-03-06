# Start from Ubuntu (e.g., bionic - 18.04.4)
FROM ubuntu

# Set default language to UTF-8 US English
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
        locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Add petab_test_suite to image
ADD petab_test_suite.tar.gz /root/project

# Install Python (e.g., 3.6.9), pip, git, setuptools and test-dependencies
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
        python3 \
        python3-pip \
        git \
    && pip3 install -U setuptools \
    && pip3 install -U pytest \
    && pip3 install -U capturer \
    && pip3 install -U mock \
    # && pip3 install -U logging \
    && pip3 install -U petab \
    && pip3 install -e /root/project/petab_test_suite \
    && git clone -branch https://github.com/paulflang/sbml2julia.git \
    && pip3 install -e /root/project/sbml2julia
    # && pip3 install -U pickle \
    # && pip3 install -U pkg_resources \
    # && pip3 install -U shutil \
    # && pip3 install -U tempfile \
    # && pip3 install -U unittest \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
    
# Install Julia v1.0.5
RUN apt update
RUN apt upgrade -y
RUN apt install curl -y
RUN curl https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz | tar -xz -C /opt/
RUN ln -s /opt/julia-1.0.5/bin/julia /usr/local/bin/julia

# Install Julia packages
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(name="JuMP", version="0.21.1"))'
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(name="Ipopt", version="0.6.1"))'
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(name="CSV", version="0.6.2"))'
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(name="DataFrames", version="0.21.1"))'
## RUN julia -e 'using Pkg; Pkg.add(PackageSpec(name="DataStructures", version="0.17.17"))'
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(name="PyCall", version="1.91.4"))'