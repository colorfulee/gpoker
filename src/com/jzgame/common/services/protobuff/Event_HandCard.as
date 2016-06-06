package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.TableCardInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Event_HandCard extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ROLESEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.Event_HandCard.roleSeatID", "roleSeatID", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var roleSeatID:int;

		/**
		 *  @private
		 */
		public static const CARDINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.Event_HandCard.cardInfo", "cardInfo", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.TableCardInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.TableCardInfo")]
		public var cardInfo:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.roleSeatID);
			for (var cardInfo$index:uint = 0; cardInfo$index < this.cardInfo.length; ++cardInfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.cardInfo[cardInfo$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var roleSeatID$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (roleSeatID$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_HandCard.roleSeatID cannot be set twice.');
					}
					++roleSeatID$count;
					this.roleSeatID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					this.cardInfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.TableCardInfo()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
