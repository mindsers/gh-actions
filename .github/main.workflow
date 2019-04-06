workflow "Tests the Publish GitHub Wiki action" {
  on = "push"
  resolves = ["Publish GitHub Wiki"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@3c98a2679187369a2116d4f311568596d3725740"
  args = "branch master"
}

action "Publish GitHub Wiki" {
  needs = ["Filters for GitHub Actions"]
  uses = "./publish-wiki/"
}
