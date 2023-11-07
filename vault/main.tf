# Specify the app in the project (one app_name per data block)
data "hcp_vault_secrets_app" "aws_app" {
  app_name = "testapp"
# Limit the scope to only one or more secrets in the app
# secret_name = “secret-name-1” “secret-name-2”
}

# Replace your existing secret references with
# data.hcp-vault-secrets_app.aws_app.secret-name

output "vault" {
  value = nonesensitive(data.hcp_vault_secrets_app.aws_app)

}