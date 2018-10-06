package com.wing.common.bootstrap.core.netty;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufHolder;
import io.netty.channel.FileRegion;
import io.netty.channel.MessageSizeEstimator;

/**
 * Default {@link MessageSizeEstimator} implementation which supports the estimation of the size of
 * {@link ByteBuf}, {@link ByteBufHolder} and byte[] and{@link FileRegion}.
 */
public final class GameMessageSizeEstimator implements MessageSizeEstimator {

    private static final class HandleImpl implements Handle {
        private final int unknownSize;

        private HandleImpl(int unknownSize) {
            this.unknownSize = unknownSize;
        }

        @Override
        public int size(Object msg) {
 
            if (msg instanceof ByteBuf) {
                return ((ByteBuf) msg).readableBytes();
            }
            if (msg instanceof ByteBufHolder) {
                return ((ByteBufHolder) msg).content().readableBytes();
            }
            if (msg instanceof byte[]) {
                return ((byte[])msg).length;
            }
            if (msg instanceof FileRegion) {
                return 0;
            } 

            return unknownSize;
        }
    }

    /**
     * Return the default implementation which returns {@code -1} for unknown messages.
     */
    public static final MessageSizeEstimator DEFAULT = new GameMessageSizeEstimator(0);

    private final Handle handle;

    /**
     * Create a new instance
     *
     * @param unknownSize       The size which is returned for unknown messages.
     */
    public GameMessageSizeEstimator(int unknownSize) {
        if (unknownSize < 0) {
            throw new IllegalArgumentException("unknownSize: " + unknownSize + " (expected: >= 0)");
        }
        handle = new HandleImpl(unknownSize);
    }

    @Override
    public Handle newHandle() {
        return handle;
    }
}
