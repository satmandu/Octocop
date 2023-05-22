FROM ruby:alpine

RUN apk add --update --no-cache build-base git jq

COPY entrypoint.sh /entrypoint.sh
COPY bin/reviewdog /bin/reviewdog

ENTRYPOINT ["/entrypoint.sh"]
