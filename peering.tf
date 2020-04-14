resource "aws_vpc_peering_connection" "foo" {
  #peer_owner_id = aws_vpc.main_vpc.id
  vpc_id = aws_vpc.main_vpc.id
  peer_vpc_id     = "${aws_vpc.main_vpc2.id}"
  auto_accept = true
}

resource "aws_vpc_peering_connection_options" "foo" {
  vpc_peering_connection_id = "${aws_vpc_peering_connection.foo.id}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_vpc_to_remote_classic_link = true
    allow_classic_link_to_remote_vpc = true
  }
}