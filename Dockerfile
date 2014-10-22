#
FROM perl:latest
MAINTAINER foilo


ADD ./ /src
WORKDIR /src
RUN cpanm -nf ./CloudMining-*/

CMD ["exec", "twiggy", "--listen",":9999","buchclub.psgi"]
ENTRYPOINT ["cloudmining"]
