workflow "Tests the Publish GitHub Wiki action" {
  resolves = ["Publish GitHub Wiki"]
  on = "push"
}

action "Publish GitHub Wiki" {
  uses = "./publish-wiki/"
}
