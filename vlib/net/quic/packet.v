module quic

import io
import net

pub const (
	quic_versionneg_version = [u8(0), 0, 0, 0]
	quic_version1_version   = [u8(0), 0, 0, 1]
)

enum QuicLongPacketType {
	initial
	zerortt
	handshake
	retry
}

pub fn parse_packet(b []u8) []Packet {
	return []
}

struct Packet {
	Bytearray
	islong bool
}
