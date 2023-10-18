import net.quic

fn test_varu62_parse() {
	mp := {
		u64(128):         [u8(0b01000000), 0b10000000]
		1024:             [u8(0b01000100), 0b00000000]
		0xffff:           [u8(0b10000000), 0, 0xff, 0xff]
		u64(1) << 62 - 1: [u8(0xff), 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]
	}
	for k, v in mp {
		u := quic.Varu62.parse(v) or { panic(err) }
		assert k == u.u64()
		assert v == u.b
	}
}
