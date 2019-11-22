#!/bin/sh

set -e

cd "${GITHUB_WORKSPACE}"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

if [ -z "${INPUT_RUBOCOP_VERSION}" ]; then
  gem install rubocop
else
  gem install rubocop -v "${INPUT_RUBOCOP_VERSION}"
fi

gem install -N rubocop-rails rubocop-performance rubocop-rspec rubocop-i18n rubocop-rake

if [ -n "${INPUT_ADDITIONAL_GEMS}" ]; then
  eval "gem install ${INPUT_ADDITIONAL_GEMS}"
fi

DIFF_BRANCH=`cat "${GITHUB_EVENT_PATH}" | jq '. | .pull_request.base.ref'`

echo "Running on diff against: $DIFF_BRANCH"

if [ -n "${INPUT_RUBOCOP_FLAGS}" ]; then
  rubocop ${INPUT_RUBOCOP_FLAGS} | /bin/reviewdog -f=rubocop -name="${INPUT_TOOL_NAME}" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}" -diff="git diff $DIFF_BRANCH"
else
  rubocop | /bin/reviewdog -f=rubocop -name="${INPUT_TOOL_NAME}" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}" -diff="git diff $DIFF_BRANCH"
fi
