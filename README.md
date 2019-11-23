![octocop](./octocop.png)

&nbsp;

Runs [rubocop](https://github.com/rubocop-hq/rubocop) and reports results with
[reviewdog](https://github.com/reviewdog/reviewdog). 

It's specifically designed for pull requests, and will report results only on the diff against the PR base.

If you're using something like CodeClimate, and don't like that existing external tools don't run against PRs that don't target your repo default branch, this is for you.

`reporter` input is important. Thanks to [reviewdog](https://github.com/reviewdog/reviewdog), this can either just fail checks at a given level, or additionally comment on the PR directly for each relevant failure.

**Requires** `on: [pull_request]` - the existing marketplace actions are more globally valid. This will still check every push to a PR.

&nbsp;

## Inputs

#### `github_token`

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`'.

#### `rubocop_flags`

Optional. String to pass to `rubocop`, defaults to passing nothing.

#### `tool_name`

Optional. Tool name to use for the resulting reviewdog report. Useful when running multiple
actions with different reviewdog reports.

#### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`].
Defaults to 'error'.

#### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-pr-review`].
Defaults to `github-pr-review`.

#### `rubocop_version`

Optional. Defaults to passing nothing to `gem install rubocop`.

#### `additional_gems`

Optional. String to pass to `gem install` after rubocop installs, if present.

&nbsp;

## Example usage

```yml
name: Rubocop

on: [pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: rubocop
      uses: Freshly/Octocop@v0.0.1
      with:
        github_token: ${{ secrets.github_token }}
        rubocop_version: 0.74
        reporter: github-pr-check
        additional_gems: "spicerack-styleguide"
        rubocop_flags: "-c rubocop/rubocop.yml --except Style/StringLiterals"
```

## Thanks and Alternatives

Originally forked from https://github.com/mgrachev/action-rubocop :heart:

Includes code from https://github.com/andrewmcodes/rubocop-linter-action :heart:

Logo thanks to the unrelated pursuits of https://github.com/dan1229/OctoCop :heart: 
