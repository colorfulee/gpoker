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
	public dynamic final class UseInteractiveItemResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SOURCESEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.UseInteractiveItemResponse.sourceseatid", "sourceseatid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var sourceseatid:int;

		/**
		 *  @private
		 */
		public static const ITEMID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.UseInteractiveItemResponse.itemid", "itemid", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var itemid:int;

		/**
		 *  @private
		 */
		public static const TARGETSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.UseInteractiveItemResponse.targetseatid", "targetseatid", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var targetseatid:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.sourceseatid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.itemid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.targetseatid);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var sourceseatid$count:uint = 0;
			var itemid$count:uint = 0;
			var targetseatid$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (sourceseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: UseInteractiveItemResponse.sourceseatid cannot be set twice.');
					}
					++sourceseatid$count;
					this.sourceseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (itemid$count != 0) {
						throw new flash.errors.IOError('Bad data format: UseInteractiveItemResponse.itemid cannot be set twice.');
					}
					++itemid$count;
					this.itemid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (targetseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: UseInteractiveItemResponse.targetseatid cannot be set twice.');
					}
					++targetseatid$count;
					this.targetseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
