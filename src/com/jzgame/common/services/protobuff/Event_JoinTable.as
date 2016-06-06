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
	import com.jzgame.common.services.protobuff.TableInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Event_JoinTable extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TABLEID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.Event_JoinTable.tableID", "tableID", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var tableID:int;

		/**
		 *  @private
		 */
		public static const TABLEROLELIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.Event_JoinTable.tableRoleList", "tableRoleList", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.TableRoleListInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.TableRoleListInfo")]
		public var tableRoleList:Array = [];

		/**
		 *  @private
		 */
		public static const TABLEINFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.Event_JoinTable.tableInfo", "tableInfo", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.TableInfo; });

		public var tableInfo:com.jzgame.common.services.protobuff.TableInfo;

		/**
		 *  @private
		 */
		public static const DEALSEATID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.Event_JoinTable.dealSeatID", "dealSeatID", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var dealSeatID:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.tableID);
			for (var tableRoleList$index:uint = 0; tableRoleList$index < this.tableRoleList.length; ++tableRoleList$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.tableRoleList[tableRoleList$index]);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.tableInfo);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dealSeatID);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var tableID$count:uint = 0;
			var tableInfo$count:uint = 0;
			var dealSeatID$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (tableID$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_JoinTable.tableID cannot be set twice.');
					}
					++tableID$count;
					this.tableID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					this.tableRoleList.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.TableRoleListInfo()));
					break;
				case 4:
					if (tableInfo$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_JoinTable.tableInfo cannot be set twice.');
					}
					++tableInfo$count;
					this.tableInfo = new com.jzgame.common.services.protobuff.TableInfo();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.tableInfo);
					break;
				case 3:
					if (dealSeatID$count != 0) {
						throw new flash.errors.IOError('Bad data format: Event_JoinTable.dealSeatID cannot be set twice.');
					}
					++dealSeatID$count;
					this.dealSeatID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
