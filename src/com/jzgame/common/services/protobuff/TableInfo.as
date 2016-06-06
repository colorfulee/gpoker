package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.TableStatus;
	import com.jzgame.common.services.protobuff.SeatInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class TableInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const DEALERPOS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableInfo.dealerpos", "dealerpos", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var dealerpos:int;

		/**
		 *  @private
		 */
		public static const CARD:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableInfo.card", "card", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var card:Array = [];

		/**
		 *  @private
		 */
		public static const POTS:RepeatedFieldDescriptor$TYPE_INT64 = new RepeatedFieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.TableInfo.pots", "pots", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("Int64")]
		public var pots:Array = [];

		/**
		 *  @private
		 */
		public static const TABLESTATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.jzgame.common.services.protobuff.TableInfo.tablestatus", "tablestatus", (4 << 3) | com.netease.protobuf.WireType.VARINT, com.jzgame.common.services.protobuff.TableStatus);

		private var tablestatus$field:int;

		private var hasField$0:uint = 0;

		public function clearTablestatus():void {
			hasField$0 &= 0xfffffffe;
			tablestatus$field = new int();
		}

		public function get hasTablestatus():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set tablestatus(value:int):void {
			hasField$0 |= 0x1;
			tablestatus$field = value;
		}

		public function get tablestatus():int {
			if(!hasTablestatus) {
				return com.jzgame.common.services.protobuff.TableStatus.IDLE;
			}
			return tablestatus$field;
		}

		/**
		 *  @private
		 */
		public static const SEATINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.TableInfo.seatinfo", "seatinfo", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.SeatInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.SeatInfo")]
		public var seatinfo:Array = [];

		/**
		 *  @private
		 */
		public static const CURRENTSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableInfo.currentseatid", "currentseatid", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		public var currentseatid:int;

		/**
		 *  @private
		 */
		public static const BLINDCHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.TableInfo.blindchips", "blindchips", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		public var blindchips:Int64;

		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableInfo.id", "id", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:int;

		/**
		 *  @private
		 */
		public static const ANTE:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.TableInfo.ante", "ante", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var ante$field:Int64;

		public function clearAnte():void {
			ante$field = null;
		}

		public function get hasAnte():Boolean {
			return ante$field != null;
		}

		public function set ante(value:Int64):void {
			ante$field = value;
		}

		public function get ante():Int64 {
			if(!hasAnte) {
				return new Int64(0, 0);
			}
			return ante$field;
		}

		/**
		 *  @private
		 */
		public static const ACTIONTIMEOUT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableInfo.actiontimeout", "actiontimeout", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		public var actiontimeout:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dealerpos);
			for (var card$index:uint = 0; card$index < this.card.length; ++card$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.card[card$index]);
			}
			for (var pots$index:uint = 0; pots$index < this.pots.length; ++pots$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.pots[pots$index]);
			}
			if (hasTablestatus) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, tablestatus$field);
			}
			for (var seatinfo$index:uint = 0; seatinfo$index < this.seatinfo.length; ++seatinfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.seatinfo[seatinfo$index]);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.currentseatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.blindchips);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.id);
			if (hasAnte) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, ante$field);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.actiontimeout);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var dealerpos$count:uint = 0;
			var tablestatus$count:uint = 0;
			var currentseatid$count:uint = 0;
			var blindchips$count:uint = 0;
			var id$count:uint = 0;
			var ante$count:uint = 0;
			var actiontimeout$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (dealerpos$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.dealerpos cannot be set twice.');
					}
					++dealerpos$count;
					this.dealerpos = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.card);
						break;
					}
					this.card.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 3:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT64, this.pots);
						break;
					}
					this.pots.push(com.netease.protobuf.ReadUtils.read$TYPE_INT64(input));
					break;
				case 4:
					if (tablestatus$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.tablestatus cannot be set twice.');
					}
					++tablestatus$count;
					this.tablestatus = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 5:
					this.seatinfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.SeatInfo()));
					break;
				case 6:
					if (currentseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.currentseatid cannot be set twice.');
					}
					++currentseatid$count;
					this.currentseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 7:
					if (blindchips$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.blindchips cannot be set twice.');
					}
					++blindchips$count;
					this.blindchips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 8:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 9:
					if (ante$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.ante cannot be set twice.');
					}
					++ante$count;
					this.ante = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 10:
					if (actiontimeout$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableInfo.actiontimeout cannot be set twice.');
					}
					++actiontimeout$count;
					this.actiontimeout = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
