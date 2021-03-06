module WebSocket
  module Handshake
    module Handler
      class Server75 < Server
        private

        # @see WebSocket::Handshake::Handler::Base#header_line
        def header_line
          'HTTP/1.1 101 Web Socket Protocol Handshake'
        end

        # @see WebSocket::Handshake::Handler::Base#handshake_keys
        def handshake_keys
          [
            %w(Upgrade WebSocket),
            %w(Connection Upgrade),
            ['WebSocket-Origin', @handshake.headers['origin']],
            ['WebSocket-Location', @handshake.uri]
          ] + protocol
        end

        def protocol
          return [] unless @handshake.headers.key?('websocket-protocol')
          proto = @handshake.headers['websocket-protocol']
          [['WebSocket-Protocol', @handshake.protocols.include?(proto) ? proto : nil]]
        end
      end
    end
  end
end
