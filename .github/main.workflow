workflow "Tests the Publish GitHub to Wiki action" {
  on = "push"
  resolves = ["Publish to GitHub Wiki"]
}

action "Publish to GitHub Wiki" {
  uses = "./publish-wiki/"
  args = "./docs"
  secrets = [
    "SSH_KEY",
    "GITHUB_TOKEN",
  ]
}
