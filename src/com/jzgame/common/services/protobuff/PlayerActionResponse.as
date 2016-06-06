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
	public dynamic final class PlayerActionResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const LASTUSERID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerActionResponse.lastuserid", "lastuserid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var lastuserid:int;

		/**
		 *  @private
		 */
		public static const LASTSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerActionResponse.lastseatid", "lastseatid", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var lastseatid:int;

		/**
		 *  @private
		 */
		public static const LASTUSERSTATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.jzgame.common.services.protobuff.PlayerActionResponse.lastuserstatus", "lastuserstatus", (3 << 3) | com.netease.protobuf.WireType.VARINT, com.jzgame.common.services.protobuff.PlayerStatus);

		public var lastuserstatus:int;

		/**
		 *  @private
		 */
		public static const LASTCHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.PlayerActionResponse.lastchips", "lastchips", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var lastchips:Int64;

		/**
		 *  @private
		 */
		public static const CURRENTSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerActionResponse.currentseatid", "currentseatid", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		public var currentseatid:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.lastuserid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.lastseatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, this.lastuserstatus);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.lastchips);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.currentseatid);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var lastuserid$count:uint = 0;
			var lastseatid$count:uint = 0;
			var lastuserstatus$count:uint = 0;
			var lastchips$count:uint = 0;
			var currentseatid$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (lastuserid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActionResponse.lastuserid cannot be set twice.');
					}
					++lastuserid$count;
					this.lastuserid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (lastseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActionResponse.lastseatid cannot be set twice.');
					}
					++lastseatid$count;
					this.lastseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (lastuserstatus$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActionResponse.lastuserstatus cannot be set twice.');
					}
					++lastuserstatus$count;
					this.lastuserstatus = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 4:
					if (lastchips$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActionResponse.lastchips cannot be set twice.');
					}
					++lastchips$count;
					this.lastchips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 5:
					if (currentseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActionResponse.currentseatid cannot be set twice.');
					}
					++currentseatid$count;
					this.currentseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
