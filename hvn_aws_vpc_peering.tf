data "aws_arn" "peer" {
  arn = aws_vpc.main.arn
}

resource "hcp_aws_network_peering" "main" {
  hvn_id          = hcp_hvn.main.hvn_id
  peering_id      = "main"
  peer_vpc_id     = aws_vpc.main.id
  peer_account_id = aws_vpc.main.owner_id
  peer_vpc_region = data.aws_arn.peer.region
}

resource "hcp_hvn_route" "main" {
  hvn_link         = hcp_hvn.main.self_link
  hvn_route_id     = "main"
  destination_cidr = "10.2.0.0/16"
  target_link      = hcp_aws_network_peering.main.self_link
}

resource "aws_vpc_peering_connection_accepter" "main" {
  vpc_peering_connection_id = hcp_aws_network_peering.main.provider_peering_id
  auto_accept               = true
}