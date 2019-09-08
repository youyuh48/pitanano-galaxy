# Pitanano Galaxy
# Galaxy-based framework for nanopore analysis
# VERSION 0.2

FROM bgruening/galaxy-stable:19.01
MAINTAINER youyuh48 <youyuh48@gmail.com>

# Enable Conda dependency resolution
ENV GALAXY_CONFIG_BRAND="Pitanano" \
  GALAXY_CONFIG_CONDA_AUTO_INIT=True \
  GALAXY_CONFIG_CONDA_AUTO_INSTALL=True \
  ENABLE_TTS_INSTALL=True

WORKDIR $GALAXY_ROOT

# Adding the tool definitions to the container
ADD config/my_tool_list.yml $GALAXY_ROOT/my_tool_list.yml
ADD config/my_tool_setup.sh $GALAXY_ROOT/my_tool_setup.sh

# Install Tools
RUN set -x && \
  install-tools $GALAXY_ROOT/my_tool_list.yml && \
  chmod +x $GALAXY_ROOT/my_tool_setup.sh && \
  $GALAXY_ROOT/my_tool_setup.sh

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
