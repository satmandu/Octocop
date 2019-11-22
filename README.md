# STILL IN DEVELOPMENT

# GitHub Action: Run rubocop with reviewdog

This action runs [rubocop](https://github.com/rubocop-hq/rubocop) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

By default, with `reporter: github-pr-check` an annotation is added to the check.

With `reporter: github-pr-review` a comment is added to the PR


### Inputs

#### `github_token`

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`'.

#### `rubocop_flags`

Optional. rubocop flags. (rubocop `<rubocop_flags>`)

#### `tool_name`

Optional. Tool name to use for reviewdog reporter. Useful when running multiple
actions with different config.

#### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`].
It's same as `-level` flag of reviewdog.

#### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-pr-review`].
The default is `github-pr-check`.

#### `rubocop_version`

Temporarily required.

#### `additional_gems`

Temporarily deprecated.

### Example usage

```yml
name: reviewdog
on: [pull_request]
jobs:
  rubocop:
    name: runner / rubocop
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: rubocop
        uses: Freshly/octocop@v0.0.1
        with:
          github_token: ${{ secrets.github_token }}
          reporter: github-pr-review # Default is github-pr-check
```
