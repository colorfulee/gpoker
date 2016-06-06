package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PlayerRecordsVO extends ValueObject
	{
		/*auther     :jim
		* file       :PlayerRecordsVO.as
		* date       :Jan 16, 2015
		* description:
		*/
//		"a": 0,
//		"b": 0,
//		"c": 0,
//		"d": 0,
//		"e": 0,
//		"f": 0,
//		"g": 0,
//		"h": 0,
//		"i": 0,
//		"j": 0,
//		"k": 0,
//		"l": 0,
//		"m": 0,
//		"n": 0,
//		"o": 0,
//		"p": 0,
//		"q": 0,
//		"r": 0,
//		"s": 0,
//		"t": 0,
//		"u": 0,
//		"v": 0,
//		"w": 0,
//		"x": 0
//		int INDEX_STATISTICS_HANDS = 0;
//		int INDEX_STATISTICS_WINS = 1;
//		int INDEX_STATISTICS_ALL_IN = 2;
//		int INDEX_STATISTICS_ALL_IN_WINS = 3;
//		int INDEX_STATISTICS_FOLDS = 4;
//		int INDEX_STATISTICS_FLOP_CARDS = 5;
//		int INDEX_STATISTICS_TURN_CARD = 6;
//		int INDEX_STATISTICS_RIVER_CARD = 7;
//		int INDEX_STATISTICS_SHOW_HANDS = 8;
//		int INDEX_STATISTICS_WIN_BY_BLINDS = 9;
//		int INDEX_STATISTICS_WIN_BY_FLOP_CARDS = 10;
//		int INDEX_STATISTICS_WIN_BY_TURN_CARD = 11;
//		int INDEX_STATISTICS_WIN_BY_RIVER_CARD = 12;
//		int INDEX_STATISTICS_WIN_BY_SHOW_HANDS = 13;
//		int INDEX_STATISTICS_ACTION_FLOD = 14;
//		int INDEX_STATISTICS_ACTION_CHECK = 15;
//		int INDEX_STATISTICS_ACTION_CALL = 16;
//		int INDEX_STATISTICS_ACTION_RAISE = 17;
//		int INDEX_STATISTICS_ACTION_RERAISE = 18;
//		int INDEX_STATISTICS_NO_FLOD = 19;
//		int INDEX_STATISTICS_FOLD_BY_BLINDS = 20;
//		int INDEX_STATISTICS_FOLD_BY_FLOP_CARDS = 21;
//		int INDEX_STATISTICS_FOLD_BY_TURN_CARD = 22;
//		int INDEX_STATISTICS_FOLD_BY_RIVER_CARD = 23;

		//hands
		public var a:Number = 0;
		//wins
		public var b:Number = 0;
		//all in
		public var c:Number = 0;
		//al in wins
		public var d:Number = 0;
		//folds
		public var e:Number = 0;
		//flop cards
		public var f:Number = 0;
		//turn card
		public var g:Number = 0;
		//river card
		public var h:Number = 0;
		//show hands
		public var i:Number = 0;
		// win by blinds
		public var j:Number = 0;
		// win by flop cards
		public var k:Number = 0;
		// win by turn cards
		public var l:Number = 0;
		// win by river cards
		public var m:Number = 0;
		// win by show hands
		public var n:Number = 0;
		//action fold
		public var o:Number = 0;
		//action check
		public var p:Number = 0;
		//action call
		public var q:Number = 0;
		//action raise
		public var r:Number = 0;
		//action reraise
		public var s:Number = 0;
		//no fold
		public var t:Number = 0;
		//fold by blinds
		public var u:Number = 0;
		//fold by flop cards
		public var v:Number = 0;
		//fold by turn card
		public var w:Number = 0;
		//fold by river card
		public var x:Number = 0;
		public function PlayerRecordsVO()
		{
			super();
		}
	}
}