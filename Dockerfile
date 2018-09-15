FROM quay.io/travelaudience/docker-nexus:3.13.0
RUN apk update && apk add maven git
WORKDIR /root
ADD . ./src
RUN cd /root/src && mvn clean install
RUN rm -rf /root/src
ENV install_dir /opt/sonatype/nexus
ENV data_dir /nexus-data
ENV keycloak_plugin_ver=0.2.1-SNAPSHOT
ENV jars "org/github/flytreeleft/nexus3-keycloak-plugin/$keycloak_plugin_ver/nexus3-keycloak-plugin-$keycloak_plugin_ver.jar"
RUN for jar in $(echo $jars | sed 's/ /\n/g'); do \
  mkdir -p $install_dir/system/$(dirname $jar); \
  cp ~/.m2/repository/$jar $install_dir/system/$jar; \
  done
RUN echo "mvn\\:org.github.flytreeleft/nexus3-keycloak-plugin/$keycloak_plugin_ver = 200" >> $install_dir/etc/karaf/startup.properties

WORKDIR /opt/sonatype/nexus
EXPOSE 8081
