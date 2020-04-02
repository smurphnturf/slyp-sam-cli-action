# Slyp sam cli action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

### `directory`
**Optional** The relative to root file path of directory to execute sam cli in.

### `args`

**Required** arg to pass into sam cli. 

## Example usage

on:[push]

jobs:
  aws_sam:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@master
      
      - name: sam build
        uses: smurphnturf/slyp-sam-cli-action@v1.0.7
        with:
          directory: ./your/path/to/template/
          args: "build"
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.TEAM_AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.TEAM_AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ap-southeast-2

## To Update
git add -u
git commit -m "Changes to commit"
git tag -a -m "Name of changes for tag" v1.y.x
git push --follow-tags