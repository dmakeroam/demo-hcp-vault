resource "hcp_vault_cluster" "main" {
  cluster_id      = "main-vault"
  hvn_id          = hcp_hvn.main.hvn_id
  public_endpoint = true
  tier            = "dev"
}

resource "hcp_vault_cluster_admin_token" "main_vault" {
  cluster_id = hcp_vault_cluster.main.cluster_id
}