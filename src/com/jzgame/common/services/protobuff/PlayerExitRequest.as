package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class PlayerExitRequest extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const USERID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerExitRequest.userid", "userid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var userid:int;

		/**
		 *  @private
		 */
		public static const ISSTANDUP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.PlayerExitRequest.isStandUp", "isStandUp", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var isStandUp:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.userid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.isStandUp);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var userid$count:uint = 0;
			var isStandUp$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (userid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerExitRequest.userid cannot be set twice.');
					}
					++userid$count;
					this.userid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (isStandUp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PlayerExitRequest.isStandUp cannot be set twice.');
					}
					++isStandUp$count;
					this.isStandUp = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
