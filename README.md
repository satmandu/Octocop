# Octocop

![octocop](./octocop.png)

Runs [rubocop](https://github.com/rubocop-hq/rubocop) and reports results with
[reviewdog](https://github.com/reviewdog/reviewdog). 

It's specifically designed for pull requests, and will report results only on the diff against the PR base.

If you're using something like CodeClimate, and don't like that existing external tools don't run against PRs that don't target your repo default branch, this is for you.

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
It's same as `-level` flag of reviewdog.

#### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-pr-review`].
The default is `github-pr-review`.

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
      uses: Freshly/octocop@v0.0.1
      with:
        github_token: ${{ secrets.github_token }}
        rubocop_version: 0.74
        reporter: github-pr-check
        additional_gems: "spicerack-styleguide"
        rubocop_flags: "-c rubocop/rubocop.yml --except Style/StringLiterals"
```

Originally forked from https://github.com/mgrachev/action-rubocop :heart:

Includes code from https://github.com/andrewmcodes/rubocop-linter-action :heart:
