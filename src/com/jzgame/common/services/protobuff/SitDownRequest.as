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
	public dynamic final class SitDownRequest extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.SitDownRequest.seatid", "seatid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var seatid:int;

		/**
		 *  @private
		 */
		public static const CHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.SitDownRequest.chips", "chips", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chips:Int64;

		/**
		 *  @private
		 */
		public static const AUTOBUY:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.jzgame.common.services.protobuff.SitDownRequest.autobuy", "autobuy", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var autobuy:Boolean = false;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.seatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.chips);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, this.autobuy);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var seatid$count:uint = 0;
			var chips$count:uint = 0;
			var autobuy$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (seatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: SitDownRequest.seatid cannot be set twice.');
					}
					++seatid$count;
					this.seatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (chips$count != 0) {
						throw new flash.errors.IOError('Bad data format: SitDownRequest.chips cannot be set twice.');
					}
					++chips$count;
					this.chips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 3:
					if (autobuy$count != 0) {
						throw new flash.errors.IOError('Bad data format: SitDownRequest.autobuy cannot be set twice.');
					}
					++autobuy$count;
					this.autobuy = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
