FROM registry.access.redhat.com/ubi8:8.4 as build
LABEL stage=builder

RUN  dnf module install --nodocs -y nodejs:14 python39 --setopt=install_weak_deps=0 --disableplugin=subscription-manager \
    && dnf install --nodocs -y git make gcc gcc-c++  --setopt=install_weak_deps=0 --disableplugin=subscription-manager \
    && dnf clean all --disableplugin=subscription-manager
    
RUN mkdir -p /opt/app-root/src
WORKDIR /opt/app-root/src
COPY ./package.json /opt/app-root/src/package.json
RUN npm install --no-audit --no-update-notifier --no-fund --production

COPY ./server.js /opt/app-root/src/
COPY ./settings.js /opt/app-root/src/
COPY ./.env /opt/app-root/src/
COPY ./flow.json /opt/app-root/src/flow.json
COPY ./flow_cred.json /opt/app-root/src/flow_cred.json

## Release image
FROM registry.access.redhat.com/ubi8/nodejs-14-minimal:1

COPY --from=build /opt/app-root/src /opt/app-root/src/

WORKDIR /opt/app-root/src

ENV PORT 1880
ENV NODE_ENV=production
#ENV TWCAPIKEY=
#ENV HEREAPIKEY=
#ENV WATSON_TTS=
EXPOSE 1880

CMD ["node", "/opt/app-root/src/server.js", "/opt/app-root/src/flow.json"]