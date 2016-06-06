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
	public dynamic final class PlayerActiontRequest extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const USERID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerActiontRequest.userid", "userid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var userid:int;

		/**
		 *  @private
		 */
		public static const USERSTATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.jzgame.common.services.protobuff.PlayerActiontRequest.userstatus", "userstatus", (2 << 3) | com.netease.protobuf.WireType.VARINT, com.jzgame.common.services.protobuff.PlayerStatus);

		public var userstatus:int;

		/**
		 *  @private
		 */
		public static const SEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerActiontRequest.seatid", "seatid", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var seatid:int;

		/**
		 *  @private
		 */
		public static const CHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.PlayerActiontRequest.chips", "chips", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chips:Int64;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.userid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, this.userstatus);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.seatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.chips);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var userid$count:uint = 0;
			var userstatus$count:uint = 0;
			var seatid$count:uint = 0;
			var chips$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (userid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActiontRequest.userid cannot be set twice.');
					}
					++userid$count;
					this.userid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (userstatus$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActiontRequest.userstatus cannot be set twice.');
					}
					++userstatus$count;
					this.userstatus = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 3:
					if (seatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActiontRequest.seatid cannot be set twice.');
					}
					++seatid$count;
					this.seatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (chips$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerActiontRequest.chips cannot be set twice.');
					}
					++chips$count;
					this.chips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
