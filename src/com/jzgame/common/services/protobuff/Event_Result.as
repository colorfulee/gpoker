package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.WinnerPrize;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Event_Result extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CHIPID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.Event_Result.chipID", "chipID", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chipID:int;

		/**
		 *  @private
		 */
		public static const WINNERPRIZE:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.Event_Result.winnerPrize", "winnerPrize", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.WinnerPrize; });

		[ArrayElementType("com.jzgame.common.services.protobuff.WinnerPrize")]
		public var winnerPrize:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.chipID);
			for (var winnerPrize$index:uint = 0; winnerPrize$index < this.winnerPrize.length; ++winnerPrize$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.winnerPrize[winnerPrize$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var chipID$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (chipID$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_Result.chipID cannot be set twice.');
					}
					++chipID$count;
					this.chipID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					this.winnerPrize.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.WinnerPrize()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
