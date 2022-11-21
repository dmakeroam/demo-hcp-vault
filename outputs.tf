output "vault_admin_token" {
  value     = hcp_vault_cluster_admin_token.main_vault.token
  sensitive = true
}