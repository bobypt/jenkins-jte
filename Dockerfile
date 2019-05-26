FROM jenkins/jenkins:2.178

# Install jenkins job builder as root
USER root
RUN apt-get update && apt-get -y upgrade && apt-get -y install python-pip
RUN pip install jenkins-job-builder

# setup job builder
RUN mkdir /etc/jenkins_jobs
COPY job_builder/jenkins_jobs.ini /etc/jenkins_jobs/jenkins_jobs.ini
COPY job_builder/defaults.yml /etc/jenkins_jobs/defaults.yml

RUN mkdir /jenkins
RUN chmod 0777 /jenkins

RUN apt-get update && \
      apt-get -y install sudo

RUN adduser jenkins sudo


# switch back to jenkins user and configure plugins
USER jenkins
RUN mkdir /jenkins/jobs/
COPY job_builder/jobs /jenkins/jobs/
COPY job_builder/bootstrap.sh /jenkins/



RUN /usr/local/bin/install-plugins.sh git mstest matrix-auth workflow-aggregator docker-workflow blueocean credentials-binding templating-engine ws-cleanup pipeline-model-definition

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home

