package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.PlayerStatus;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class PlayerInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const UID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.uid", "uid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var uid:int;

		/**
		 *  @private
		 */
		public static const FACEID:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.PlayerInfo.faceid", "faceid", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var faceid:String;

		/**
		 *  @private
		 */
		public static const CHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.PlayerInfo.chips", "chips", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chips:Int64;

		/**
		 *  @private
		 */
		public static const USERNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.PlayerInfo.username", "username", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var username:String;

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.level", "level", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:int;

		/**
		 *  @private
		 */
		public static const CAPITAL:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.PlayerInfo.capital", "capital", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		public var capital:Int64;

		/**
		 *  @private
		 */
		public static const VIPLEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.viplevel", "viplevel", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		public var viplevel:int;

		/**
		 *  @private
		 */
		public static const STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.jzgame.common.services.protobuff.PlayerInfo.status", "status", (8 << 3) | com.netease.protobuf.WireType.VARINT, com.jzgame.common.services.protobuff.PlayerStatus);

		public var status:int;

		/**
		 *  @private
		 */
		public static const SEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.seatid", "seatid", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		public var seatid:int;

		/**
		 *  @private
		 */
		public static const WINNING:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.winning", "winning", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		public var winning:int;

		/**
		 *  @private
		 */
		public static const LOCATION:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.PlayerInfo.location", "location", (11 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var location$field:String;

		public function clearLocation():void {
			location$field = null;
		}

		public function get hasLocation():Boolean {
			return location$field != null;
		}

		public function set location(value:String):void {
			location$field = value;
		}

		public function get location():String {
			if(!hasLocation) {
				return "home";
			}
			return location$field;
		}

		/**
		 *  @private
		 */
		public static const CARD:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.card", "card", (12 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var card:Array = [];

		/**
		 *  @private
		 */
		public static const GIFTID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.giftid", "giftid", (13 << 3) | com.netease.protobuf.WireType.VARINT);

		public var giftid:int;

		/**
		 *  @private
		 */
		public static const EXP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerInfo.exp", "exp", (14 << 3) | com.netease.protobuf.WireType.VARINT);

		public var exp:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.uid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.faceid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.chips);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.username);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.level);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.capital);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.viplevel);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
			com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, this.status);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.seatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.winning);
			if (hasLocation) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, location$field);
			}
			for (var card$index:uint = 0; card$index < this.card.length; ++card$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.card[card$index]);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.giftid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 14);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.exp);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var uid$count:uint = 0;
			var faceid$count:uint = 0;
			var chips$count:uint = 0;
			var username$count:uint = 0;
			var level$count:uint = 0;
			var capital$count:uint = 0;
			var viplevel$count:uint = 0;
			var status$count:uint = 0;
			var seatid$count:uint = 0;
			var winning$count:uint = 0;
			var location$count:uint = 0;
			var giftid$count:uint = 0;
			var exp$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (uid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.uid cannot be set twice.');
					}
					++uid$count;
					this.uid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (faceid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.faceid cannot be set twice.');
					}
					++faceid$count;
					this.faceid = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (chips$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.chips cannot be set twice.');
					}
					++chips$count;
					this.chips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 4:
					if (username$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.username cannot be set twice.');
					}
					++username$count;
					this.username = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 5:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 6:
					if (capital$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.capital cannot be set twice.');
					}
					++capital$count;
					this.capital = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 7:
					if (viplevel$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.viplevel cannot be set twice.');
					}
					++viplevel$count;
					this.viplevel = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 8:
					if (status$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.status cannot be set twice.');
					}
					++status$count;
					this.status = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 9:
					if (seatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.seatid cannot be set twice.');
					}
					++seatid$count;
					this.seatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10:
					if (winning$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.winning cannot be set twice.');
					}
					++winning$count;
					this.winning = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11:
					if (location$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.location cannot be set twice.');
					}
					++location$count;
					this.location = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 12:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.card);
						break;
					}
					this.card.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 13:
					if (giftid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.giftid cannot be set twice.');
					}
					++giftid$count;
					this.giftid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 14:
					if (exp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerInfo.exp cannot be set twice.');
					}
					++exp$count;
					this.exp = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
