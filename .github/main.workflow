workflow "New workflow" {
  on = "push"
  resolves = ["Publish GitHub Wiki"]
}

action "Publish GitHub Wiki" {
  uses = "./publish-wiki/"
}
