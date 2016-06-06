package com.jzgame.common.services.protobuff {
	public final class PlayerStatus {
		public static const OBSERVING:int = 0;
		public static const PLAYING_IDLE:int = 1;
		public static const PLAYING_ALLIN:int = 2;
		public static const PLAYING_FOLD:int = 3;
		public static const PLAYING_CALL:int = 4;
		public static const PLAYING_RAISE:int = 5;
		public static const PLAYING_CHECK:int = 6;
		public static const PLAYING_BLIND_LITTLE:int = 7;
		public static const PLAYING_BLIND_BIGGER:int = 8;
		public static const PLAYING_READY:int = 9;
		public static const PLAYING_ANTE:int = 10;
	}
}
