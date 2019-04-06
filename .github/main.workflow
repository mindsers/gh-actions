workflow "New workflow" {
  on = "push"
  resolves = ["new-action"]
}

action "Publish GitHub Wiki" {
  uses = "./publish-wiki"
}
