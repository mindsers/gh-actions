workflow "Test \"Pub" {
  resolves = ["Publish GitHub Wiki"]
  on = "push"
}

action "Publish GitHub Wiki" {
  uses = "./publish-wiki/"
}
