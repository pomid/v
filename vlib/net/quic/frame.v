module quic

enum FrameType as u32 {
	padding
	ping
	ack
	ackecn
	reset_stream
	stop_sending
	crypto
	new_token
	stream
	stream_f
	stream_l
	stream_lf
	stream_o
	stream_of
	stream_ol
	stream_olf
	max_data
	max_stream_data
	max_streams_bi
	max_streams_uni
	data_blocked
	stream_data_blocked
	streams_blocked_bi
	streams_blocked_uni
	new_cid
	retire_cid
	path_challenge
	path_response
	conn_close_quicerr
	conn_close_apperr
	handshake_done
}

struct Frame {
	@type FrameType
}

// fn extractframes(b &u8[]) map[]
