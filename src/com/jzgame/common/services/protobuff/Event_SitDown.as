package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.TableRoleListInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Event_SitDown extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.Event_SitDown.seatID", "seatID", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var seatID:int;

		/**
		 *  @private
		 */
		public static const ROLEINFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.Event_SitDown.roleInfo", "roleInfo", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.TableRoleListInfo; });

		public var roleInfo:com.jzgame.common.services.protobuff.TableRoleListInfo;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.seatID);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.roleInfo);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var seatID$count:uint = 0;
			var roleInfo$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (seatID$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_SitDown.seatID cannot be set twice.');
					}
					++seatID$count;
					this.seatID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (roleInfo$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_SitDown.roleInfo cannot be set twice.');
					}
					++roleInfo$count;
					this.roleInfo = new com.jzgame.common.services.protobuff.TableRoleListInfo();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.roleInfo);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
