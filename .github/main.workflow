workflow "Tests the Publish GitHub Wiki action" {
  on = "push"
  resolves = ["Publish GitHub Wiki"]
}

action "Publish GitHub Wiki" {
  uses = "./publish-wiki/"
  args = "./docs"
  secrets = ["SSH_KEY"]
}
