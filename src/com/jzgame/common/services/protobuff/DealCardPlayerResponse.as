package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.PlayerInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class DealCardPlayerResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const DEALERSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.DealCardPlayerResponse.dealerseatid", "dealerseatid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var dealerseatid:int;

		/**
		 *  @private
		 */
		public static const CURRENTSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.DealCardPlayerResponse.currentseatid", "currentseatid", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var currentseatid:int;

		/**
		 *  @private
		 */
		public static const USERID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.DealCardPlayerResponse.userid", "userid", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var userid:int;

		/**
		 *  @private
		 */
		public static const CARD:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.DealCardPlayerResponse.card", "card", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var card:Array = [];

		/**
		 *  @private
		 */
		public static const PLAYERINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.DealCardPlayerResponse.playerinfo", "playerinfo", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.PlayerInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.PlayerInfo")]
		public var playerinfo:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dealerseatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.currentseatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.userid);
			for (var card$index:uint = 0; card$index < this.card.length; ++card$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.card[card$index]);
			}
			for (var playerinfo$index:uint = 0; playerinfo$index < this.playerinfo.length; ++playerinfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.playerinfo[playerinfo$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var dealerseatid$count:uint = 0;
			var currentseatid$count:uint = 0;
			var userid$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (dealerseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: DealCardPlayerResponse.dealerseatid cannot be set twice.');
					}
					++dealerseatid$count;
					this.dealerseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (currentseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: DealCardPlayerResponse.currentseatid cannot be set twice.');
					}
					++currentseatid$count;
					this.currentseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (userid$count != 0) {
						throw new flash.errors.IOError('Bad data format: DealCardPlayerResponse.userid cannot be set twice.');
					}
					++userid$count;
					this.userid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.card);
						break;
					}
					this.card.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 5:
					this.playerinfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.PlayerInfo()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
