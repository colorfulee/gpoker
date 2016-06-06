package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.RewardInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class PlayerGameRankResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const RANK:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerGameRankResponse.rank", "rank", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var rank:int;

		/**
		 *  @private
		 */
		public static const GAMEMODE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerGameRankResponse.gamemode", "gamemode", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var gamemode:int;

		/**
		 *  @private
		 */
		public static const REWARD:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.PlayerGameRankResponse.reward", "reward", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var reward$field:Int64;

		public function clearReward():void {
			reward$field = null;
		}

		public function get hasReward():Boolean {
			return reward$field != null;
		}

		public function set reward(value:Int64):void {
			reward$field = value;
		}

		public function get reward():Int64 {
			return reward$field;
		}

		/**
		 *  @private
		 */
		public static const REWARDINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.PlayerGameRankResponse.rewardinfo", "rewardinfo", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.RewardInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.RewardInfo")]
		public var rewardinfo:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.rank);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.gamemode);
			if (hasReward) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, reward$field);
			}
			for (var rewardinfo$index:uint = 0; rewardinfo$index < this.rewardinfo.length; ++rewardinfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.rewardinfo[rewardinfo$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var rank$count:uint = 0;
			var gamemode$count:uint = 0;
			var reward$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (rank$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerGameRankResponse.rank cannot be set twice.');
					}
					++rank$count;
					this.rank = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (gamemode$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerGameRankResponse.gamemode cannot be set twice.');
					}
					++gamemode$count;
					this.gamemode = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (reward$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerGameRankResponse.reward cannot be set twice.');
					}
					++reward$count;
					this.reward = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 4:
					this.rewardinfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.RewardInfo()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
