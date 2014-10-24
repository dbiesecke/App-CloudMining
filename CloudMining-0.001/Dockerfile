#
FROM perl:latest
MAINTAINER foilo


ADD ./ /src
WORKDIR /src
RUN cpanm -nf ./CloudMining-*

CMD ["help"]
ENTRYPOINT ["cloudmining"]
