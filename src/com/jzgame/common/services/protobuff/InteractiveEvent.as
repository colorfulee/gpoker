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
	public dynamic final class InteractiveEvent extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const EVENTID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.InteractiveEvent.eventid", "eventid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var eventid:int;

		/**
		 *  @private
		 */
		public static const SRCSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.InteractiveEvent.srcseatid", "srcseatid", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var srcseatid:int;

		/**
		 *  @private
		 */
		public static const TARGETSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.InteractiveEvent.targetseatid", "targetseatid", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var targetseatid:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.eventid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.srcseatid);
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
			var eventid$count:uint = 0;
			var srcseatid$count:uint = 0;
			var targetseatid$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (eventid$count != 0) {
						throw new flash.errors.IOError('Bad data format: InteractiveEvent.eventid cannot be set twice.');
					}
					++eventid$count;
					this.eventid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (srcseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: InteractiveEvent.srcseatid cannot be set twice.');
					}
					++srcseatid$count;
					this.srcseatid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (targetseatid$count != 0) {
						throw new flash.errors.IOError('Bad data format: InteractiveEvent.targetseatid cannot be set twice.');
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
